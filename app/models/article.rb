class Article < ApplicationRecord
  belongs_to :category
  belongs_to :account

  enum status: [:draft, :publish]
  ARTICLE_ATTRIBUTES = [:title, :content, :category_id, :status, :total_vote]
end
