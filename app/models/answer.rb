class Answer < ApplicationRecord
  belongs_to :account
  belongs_to :question
  has_many :comments, as: :commentable

  ANSWER_ATTRIBUTES = [:content, :total_vote, :question_id]
end
