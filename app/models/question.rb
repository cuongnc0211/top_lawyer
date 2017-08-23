class Question < ApplicationRecord
  belongs_to :category
  belongs_to :account

  QUESTION_ATTRIBUTES = [:title, :content, :category_id]
end
