class Lawyer::ClipsController < Lawyer::BaseController
  def index
    ids = current_account.clips.pluck :article_id
    @articles = Article.where(id: ids.to_a).page(params[:pgae]).per Settings.paginate.default
  end
end
