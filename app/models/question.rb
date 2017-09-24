class Question < ApplicationRecord
  has_many :answers
  belongs_to :category
  belongs_to :account

  QUESTION_ATTRIBUTES = [:title, :content, :category_id]

  delegate :name, to: :account, prefix: true, allow_nil: true
end
