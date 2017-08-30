class Votes::UpdateTotalVotesService
  attr_reader :object

  def initialize object
    @object = object
  end

  def perform
    object.update_attributes total_vote: object.all_vote
  end
end
