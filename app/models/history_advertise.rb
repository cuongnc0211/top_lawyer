class HistoryAdvertise < ApplicationRecord
  has_one :history_point
  belongs_to :account

  HISTORY_ADVERTISE_ATTRIBUTES = [:category_id, :start_time, :end_time]

  def advertise_period
    (end_time.to_date - start_time.to_date).to_i
  end
end
