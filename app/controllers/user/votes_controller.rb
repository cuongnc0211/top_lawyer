class User::VotesController < User::BaseController
  before_action :vote, only: :destroy

  def create
    @vote = current_account.votes.build vote_parmas
    @article = Article.find params[:vote][:voteable_id]
    if @vote.save
      update_infomation @article
      ::Notifies::CreateNotificationService.new(current_account: current_account,
        target_account: @article.account, model: @article, action: :up_vote).perform
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @article = Article.find params[:vote][:voteable_id]
    if @vote.destroy
      update_infomation @article
      ::Notifies::CreateNotificationService.new(current_account: current_account,
        target_account: @article.account, model: @article, action: :down_vote).perform
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

  def update_infomation article
    ::CreateHistoryPointService.new(point: Point.article, account: article.account)
    ::UpdatePointLawyerService.new(article.lawyer_profile).perform
    ::Votes::UpdateTotalVotesService.new(article).perform
  end
end
