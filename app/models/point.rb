class Point < ApplicationRecord
  has_many :history_point

  enum option: [:answer, :article, :vote_up, :vote_down, :advertise]

  scope :bonus_point, -> {where.not option: :advertise}
  scope :point_by_type, ->(point_type) {where(option: point_type).first}
  scope :update_reputation, -> account_id do
    find_by_sql(["
      select SUM(history_points.total) as total
      From points
      LEFT OUTER JOIN history_points ON `points`.`id` = `history_points`.`point_id`
      where points.option != 4 AND history_points.account_id = ?
      group by history_points.account_id
    ", account_id])
  end

end
