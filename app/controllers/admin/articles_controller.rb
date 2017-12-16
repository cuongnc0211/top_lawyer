class Admin::ArticlesController < Admin::BaseController
  def index
    search_content = params[:q]
    @articles = Article.search(title_or_content_cont: search_content).result(distinct: true)
      .page(params[:page]).per Settings.search.per_page.default
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:success] = t ".deleted"
      redirect_to admin_articles_path
    else
      flash[:error] = t ".delete_fail"
      redirect_to admin_articles_path
    end
  end
end
