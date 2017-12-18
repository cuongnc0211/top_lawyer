class User::VotesController < User::BaseController
  before_action :vote, only: :destroy

  def create
    @vote = current_account.votes.build vote_parmas
    load_model params[:vote][:voteable_type], params[:vote][:voteable_id]
    if @vote.save
      update_infomation @model, @vote.voteable_type, @vote.vote_type.to_sym
      respond_to{|format| format.js}
    else
      flash.now[:error] = t ".failed"
    end
    point = @vote.vote_up? ? Point.vote_up.first : Point.vote_down.first
    unless params[:vote][:voteable_type] == "Question"
      ::CreateHistoryPointService.new(point: point, account: @model.account).perform
      ::UpdatePointLawyerService.new(@model.account.lawyer_profile).perform
    end
  end

  def destroy
    load_model params[:vote][:voteable_type], params[:vote][:voteable_id]
    vote_type = @vote.voteable_type
    if @vote.destroy
      update_infomation @model, vote_type, :vote_down
      @vote = @model.init_vote(current_account.id)
      respond_to{|format| format.js}
    else
      flash.now[:error] = t ".failed"
    end
    point = Point.vote_down.first
    unless params[:vote][:voteable_type] == "Question"
      ::CreateHistoryPointService.new(point: point, account: @model.account).perform
      ::UpdatePointLawyerService.new(@model.account.lawyer_profile).perform
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

  def update_infomation model, voteable_type, action
    case voteable_type
    when "Article"
      ::Notifies::CreateNotificationService.new(current_account: current_account,
        target_account: @model.account, model: @model, action: action).perform
    when "Question"
    when "Answer"
      ::Notifies::CreateNotificationService.new(current_account: current_account,
        target_account: @model.account, model: @model, action: action).perform
    end
    ::Votes::UpdateTotalVotesService.new(model).perform
  end
end
