class Point < ApplicationRecord
  has_many :history_point

  enum option: [:answer, :article, :vote_up, :vote_down, :advertise]

  scope :bonus_point, -> {where.not option: :advertise}
  scope :point_by_type, ->(point_type) {where(option: point_type).first}
end
