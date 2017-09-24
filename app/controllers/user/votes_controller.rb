class User::VotesController < User::BaseController
  before_action :vote, only: :destroy

  def create
    @vote = current_account.votes.build vote_parmas
    @article = Article.find params[:vote][:voteable_id]
    if @vote.save
      update_infomation @article
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @article = Article.find params[:vote][:voteable_id]
    if @vote.destroy
      update_infomation @article
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
    ::Votes::UpdatePointLawyerService.new(article.lawyer_profile).perform
    ::Votes::UpdateTotalVotesService.new(article).perform
  end
end
