class CreateHistoryPointService
  attr_reader :point, :account, :amount

  def initialize args
    @point = args[:point]
    @account = args[:account]
    @amount = args[:amount] || 1
  end

  def perform
    total = point.point_per_time * amount
    hp = HistoryPoint.create account_id: account.id, point_id: point.id, amount: amount, total: total
  end
end
