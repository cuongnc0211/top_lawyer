class UpdatePointLawyerService
  attr_reader :lawyer_profile

  def initialize lawyer_profile
    @lawyer_profile = lawyer_profile
  end

  def perform
    account = lawyer_profile.account
    point = account.history_points.sum(:total)
    reputation = account.history_points.joins(:point).where.not(points: {option: :advertise}).sum(:total)
    lawyer_profile.update_attributes point: point, reputation: reputation
  end
end
