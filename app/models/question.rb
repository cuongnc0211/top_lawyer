class Question < ApplicationRecord
  is_impressionable

  has_many :answers
  belongs_to :category
  belongs_to :account
  has_many :votes, as: :voteable
  has_many :notifies, as: :notifyable

  acts_as_taggable

  QUESTION_ATTRIBUTES = [:title, :content, :category_id, :tag_list]

  delegate :name, to: :account, prefix: true, allow_nil: true
  delegate :name, to: :category, prefix: true, allow_nil: true
  delegate :account_avatar_url, to: :account, prefix: false, allow_nil: true

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
