class Category < ApplicationRecord
  has_many :questions
  has_many :articles
  has_many :follow_categories
  has_many :articles
end
