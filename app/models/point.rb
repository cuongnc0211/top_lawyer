class Point < ApplicationRecord
  has_many :history_point

  enum option: [:answer, :article, :vote_up, :vote_down, :advertise]
end
