class User::VotesController < User::BaseController
  before_action :vote, only: :destroy

  def create
    @vote = current_account.votes.build vote_parmas
    load_model params[:vote][:voteable_type], params[:vote][:voteable_id]
    if @vote.save
      update_infomation @model, @vote.voteable_type
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    load_model params[:vote][:voteable_type], params[:vote][:voteable_id]
    vote_type = @vote.voteable_type
    if @vote.destroy
      update_infomation @model, vote_type
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def vote_parmas
    params.require(:vote).permit Vote::VOTE_ATTRIBUTES
  end

  def vote
    @vote = current_account.votes.find_by id: params[:id]
  end

  def load_model vote_type, model_id
    case vote_type
    when "Article"
      @model = Article.find model_id
    when "Question"
      @model = Question.find model_id
    when "Answer"
      @model = Answer.find model_id
    end
  end

  def update_infomation model, vote_type
    case vote_type
    when "Article"
      ::CreateHistoryPointService.new(point: Point.article, account: model.account)
      ::UpdatePointLawyerService.new(model.account.lawyer_profile).perform
      ::Notifies::CreateNotificationService.new(current_account: current_account,
        target_account: @model.account, model: @model, action: :up_vote).perform
    when "Question"
    when "Answer"
      ::CreateHistoryPointService.new(point: Point.answer, account: model.account)
      ::UpdatePointLawyerService.new(model.account.lawyer_profile).perform
      ::Notifies::CreateNotificationService.new(current_account: current_account,
        target_account: @model.account, model: @model, action: :down_vote).perform
    end
    ::Votes::UpdateTotalVotesService.new(model).perform
  end
end
