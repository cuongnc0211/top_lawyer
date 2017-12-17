class TagDescription < ApplicationRecord
  belongs_to :tag

  validates :content, presence: true
end
