class Review < ApplicationRecord
  belongs_to :account
  belongs_to :reviewable, polymorphic: true
end
