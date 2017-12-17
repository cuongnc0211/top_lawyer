class HistoryAdvertise < ApplicationRecord
  has_one :history_point
  belongs_to :account

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :category_id, presence: true

  HISTORY_ADVERTISE_ATTRIBUTES = [:category_id, :start_time, :end_time]

  scope :unexpired, -> {where("DATE(start_time) <= ? AND DATE(end_time) >= ?", Time.zone.now.to_date, Time.zone.now.to_date)}
  scope :in_category, -> (id_category) {where category_id: id_category}
  scope :out_category, -> (id_category) {unexpired.where.not category_id: id_category}

  def advertise_period
    (end_time.to_date - start_time.to_date).to_i
  end

  scope :advertise_lawyer, ->(id_category, limit) do
    unexpired.in_category(id_category).joins(:account).order(:created_at)
  end
end
