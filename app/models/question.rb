class Question < ApplicationRecord
  is_impressionable

  has_many :answers
  belongs_to :category
  belongs_to :account

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
end
