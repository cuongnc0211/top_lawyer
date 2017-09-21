class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :account
  COMMENT_ATTRIBUTES = [:account_id, :content, :type]

  acts_as_tree order: 'created_at DESC'

end
