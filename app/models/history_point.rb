class HistoryPoint < ApplicationRecord
  belongs_to :point
  belongs_to :account
end
