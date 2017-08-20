class Article < ApplicationRecord
  belongs_to :category
  belongs_to :account

  enum status: [:draft, :publish]
end
