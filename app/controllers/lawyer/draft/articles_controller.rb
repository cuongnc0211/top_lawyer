class Lawyer::Draft::ArticlesController < Lawyer::BaseController
  def index
    @articles = current_account.articles.draft.page(params[:page])
      .per Settings.per_page.default
  end
end
