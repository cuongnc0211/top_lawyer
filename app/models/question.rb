class Question < ApplicationRecord
  is_impressionable
  acts_as_taggable

  has_many :answers
  belongs_to :category
  belongs_to :account
  has_many :votes, as: :voteable
  has_many :notifies, as: :notifyable

  validates :title, presence: true, length: {maximum: 1000}
  validates :content, presence: true
  validates :category_id, presence: true

  QUESTION_ATTRIBUTES = [:title, :content, :category_id, :tag_list]

  delegate :name, to: :account, prefix: true, allow_nil: true
  delegate :name, to: :category, prefix: true, allow_nil: true
  delegate :account_avatar_url, to: :account, prefix: false, allow_nil: true

  scope :all_feed, -> do
    find_by_sql("
      select x.*, (x.view_count - x.answer_count*2 + x.total_vote*4 - x.hours) AS rank
      FROM (SELECT  questions.* , COUNT(DISTINCT impressions.session_hash) AS view_count,
      COUNT(DISTINCT answers.id) AS answer_count,
      extract(hour from age(now(), questions.created_at)) AS hours
        FROM questions
        LEFT OUTER JOIN impressions ON impressions.impressionable_id = questions.id AND impressions.impressionable_type = 'Question'
        LEFT OUTER JOIN answers ON answers.question_id = questions.id
      GROUP BY questions.id) x
      ORDER BY rank DESC
    ")
  end

  scope :new_feed, -> category_ids do
    find_by_sql(["
      select x.*, (x.view_count - x.answer_count*2 + x.total_vote*4 - x.hours) AS rank
      FROM (SELECT  questions.* , COUNT(DISTINCT impressions.session_hash) AS view_count,
      COUNT(DISTINCT answers.id) AS answer_count,
      extract(hour from age(now(), questions.created_at)) AS hours
        FROM questions
        LEFT OUTER JOIN impressions ON impressions.impressionable_id = questions.id AND impressions.impressionable_type = 'Question'
        LEFT OUTER JOIN answers ON answers.question_id = questions.id
      GROUP BY questions.id) x
      WHERE x.category_id IN (?)
      ORDER BY rank DESC
    ", category_ids])
  end

  def related_questions
    questions = Question.tagged_with(self.tag_list, any: true).where.not(id: self.id)
      .first(Settings.question.related)

    gap = Settings.question.related - questions.length
    if gap > 0
      questions += self.category.questions.order(total_vote: :desc).first(gap)
    end
    questions
  end

  def init_vote account_id
    votes.find_by(account_id: account_id) || votes.build
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
