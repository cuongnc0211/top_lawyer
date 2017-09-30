class HistoryPoint < ApplicationRecord
  belongs_to :point
  belongs_to :account

  HISTORY_POINT_ATTRIBUTES = [:category_id, :province_id, :start_time, :end_time]
end
