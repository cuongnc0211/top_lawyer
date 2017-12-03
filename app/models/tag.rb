class Tag < ApplicationRecord
  has_many :tag_descriptions

  accepts_nested_attributes_for :tag_descriptions, allow_destroy: true

  TAG_ATTRIBUTE = [:id, :name, tag_descriptions_attributes: [:account_id, :tag_id, :content]]
end
