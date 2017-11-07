class Admin::ArticlesController < Admin::BaseController
  def index
    @articles = Kaminari.paginate_array(Article.all.reverse).page(params[:page]).per Settings.paginate.default
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
