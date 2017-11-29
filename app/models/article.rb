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

  acts_as_taggable

  enum status: [:draft, :publish]

  ARTICLE_ATTRIBUTES = [:title, :content, :category_id, :status, :total_vote, :tag_list]

  delegate :name, to: :category, prefix: true, allow_nil: true
  delegate :name, to: :account, prefix: true, allow_nil: true
  delegate :account_avatar_url, to: :account, prefix: false, allow_nil: true

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
end
