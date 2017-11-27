class Question < ApplicationRecord
  is_impressionable
  
  has_many :answers
  belongs_to :category
  belongs_to :account

  QUESTION_ATTRIBUTES = [:title, :content, :category_id]

  delegate :name, to: :account, prefix: true, allow_nil: true
  delegate :name, to: :category, prefix: true, allow_nil: true
  delegate :account_avatar_url, to: :account, prefix: false, allow_nil: true
end
