class HistoryPoint < ApplicationRecord
  belongs_to :point
  belongs_to :account

  HISTORY_POINT_ATTRIBUTES = [:category_id, :province_id, :start_time, :end_time]

  scope :bonus_point, ->{where "total >= 0"}
  scope :in_last_month, -> do
    where created_at: 29.days.ago.beginning_of_day..Time.zone.now.end_of_day
  end
end
