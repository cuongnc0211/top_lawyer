class CreateHistoryPointService
  attr_reader :point, :account

  def initialize args
    @point = args[:point]
    @account = args[:account]
  end

  def perform
    HistoryPoint.create account_id: account.id, point_id: point.id
  end
end
