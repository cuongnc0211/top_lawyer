class FollowCategory < ApplicationRecord
  belongs_to :account
  belongs_to :category
end
