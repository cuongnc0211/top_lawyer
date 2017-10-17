class Vote < ApplicationRecord
  belongs_to :voteable, polymorphic: true
  belongs_to :account
  has_many :notifies, as: :notifyable

  VOTE_ATTRIBUTES = [:vote_type, :voteable_type, :voteable_id]

  enum vote_type: [:vote_up, :vote_down]
end
