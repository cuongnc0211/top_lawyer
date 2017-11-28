class Answer < ApplicationRecord
  belongs_to :account
  belongs_to :question
  has_many :comments, as: :commentable

  ANSWER_ATTRIBUTES = [:content, :total_vote, :question_id]

  delegate :name, to: :account, prefix: true, allow_nil: true
  delegate :account_avatar_url, to: :account, prefix: false, allow_nil: true

end
