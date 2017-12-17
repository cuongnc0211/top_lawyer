class Tag < ApplicationRecord
  has_many :tag_descriptions

  validates :name, presence: true, uniqueness: true

  accepts_nested_attributes_for :tag_descriptions, allow_destroy: true

  TAG_ATTRIBUTE = [:id, :name, tag_descriptions_attributes: [:account_id, :tag_id, :content]]
end
