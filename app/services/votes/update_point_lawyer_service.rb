class Votes::UpdatePointLawyerService
  attr_reader :lawyer_profile

  def initialize lawyer_profile
    @lawyer_profile = lawyer_profile
  end

  def perform
    point = lawyer_profile.total_point
    lawyer_profile.update_attributes point: point
  end
end
