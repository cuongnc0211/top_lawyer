class Answer < ApplicationRecord
  belongs_to :account
  belongs_to :question

  ANSWER_ATTRIBUTES = [:content, :total_vote, :question_id]
end
