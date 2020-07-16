class Article < ApplicationRecord
  is_impressionable

  belongs_to :category
  belongs_to :account
  has_one :lawyer_profile, through: :account
  has_many :votes, as: :voteable
  has_many :comments, as: :commentable
  has_many :notifies, as: :notifyable
  has_many :clips
  has_many :taggings, as: :taggable

  validates :title, presence: true, length: {maximum: 1000}
  validates :content, presence: true
  validates :category_id, presence: true

  acts_as_taggable

  enum status: [:draft, :publish]

  ARTICLE_ATTRIBUTES = [:title, :content, :category_id, :status, :total_vote, :tag_list]

  delegate :name, to: :category, prefix: true, allow_nil: true
  delegate :name, to: :account, prefix: true, allow_nil: true
  delegate :account_avatar_url, to: :account, prefix: false, allow_nil: true

  scope :in_category, -> ids do
    where(category_id: ids)
  end

  scope :all_feed, -> do
    find_by_sql("
      select x.*, (x.view_count + x.comment_count*2 + x.clip_count*3 + x.total_vote*3 - x.hours) AS rank
      FROM (SELECT  articles.* , COUNT(DISTINCT impressions.session_hash) AS view_count ,
      COUNT(DISTINCT comments.id) AS comment_count,
      COUNT(DISTINCT clips.id) AS clip_count,
      extract(hour from age(now(), articles.created_at)) AS hours
        FROM articles
        LEFT OUTER JOIN impressions ON impressions.impressionable_id = articles.id AND impressions.impressionable_type = 'Article'
        LEFT OUTER JOIN comments ON comments.commentable_id = articles.id AND comments.commentable_type = 'Article'
        LEFT OUTER JOIN clips ON clips.article_id = articles.id GROUP BY articles.id) x
      ORDER BY rank DESC
    ")
  end

  scope :new_feed, -> category_ids do
    find_by_sql(["
      select x.*, (x.view_count + x.comment_count*2 + x.clip_count*3 + x.total_vote*3 - x.hours) AS rank
      FROM (SELECT  articles.* , COUNT(DISTINCT impressions.session_hash) AS view_count ,
      COUNT(DISTINCT comments.id) AS comment_count,
      COUNT(DISTINCT clips.id) AS clip_count,
      extract(hour from age(now(), articles.created_at)) AS hours
        FROM articles
        LEFT OUTER JOIN impressions ON impressions.impressionable_id = articles.id AND impressions.impressionable_type = 'Article'
        LEFT OUTER JOIN comments ON comments.commentable_id = articles.id AND comments.commentable_type = 'Article'
        LEFT OUTER JOIN clips ON clips.article_id = articles.id GROUP BY articles.id) x
      WHERE x.category_id IN (?)
      ORDER BY rank DESC
    ", category_ids])
  end

  def related_articles
    articles = Article.tagged_with(self.tag_list, any: true).where.not(id: self.id)
      .first(Settings.article.related)
    gap = Settings.article.related - articles.length
    if gap > 0
      articles += self.category.articles.order(total_vote: :desc).first(gap)
    end
    articles
  end

  def init_vote account_id
    votes.find_by(account_id: account_id) || votes.build
  end

  def init_clip account_id
    clips.find_by(account_id: account_id) || clips.build
  end

  def all_vote
    all_vote_up - all_vote_down
  end

  def all_vote_down
    votes.vote_down.count
  end

  def all_vote_up
    votes.vote_up.count
  end

  def all_tags
    Tag.find(self.tags.pluck :id)
  end
end
