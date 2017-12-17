class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :account
  has_many :notifies, as: :notifyable

  COMMENT_ATTRIBUTES = [:account_id, :content, :type]

  validates :content, presence: true

  acts_as_tree order: 'created_at DESC'
end
