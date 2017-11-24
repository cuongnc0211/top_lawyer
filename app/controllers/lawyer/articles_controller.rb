class Lawyer::ArticlesController < Lawyer::BaseController
  before_action :article

  def index
    @articles = current_account.articles
  end

  def show
  end

  def new
    @article = Article.new
    @categories = Category.all
    @tags = Tag.all.where.not(name: @article.tags.pluck(:name))
    gon.tags = @article.tags.pluck(:name)
  end

  def edit
    @article = Article.find(params[:id])
    @categories = Category.all
    @tags = Tag.all.where.not(name: @article.tags.pluck(:name))
    gon.tags = @article.tags.pluck(:name)
  end

  def create
    @categories = Category.all
    @article = current_account.articles.new(article_params)
    if @article.save
      redirect_to lawyer_articles_path
      flash[:success] = t ".new"
    else
      puts @article.errors.full_messages
      flash.now[:alert] = t ".Please_correct_the_form"
      render :new
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes article_params
      flash[:success] = t ".updated"
      redirect_to lawyer_articles_path
    else
      puts @article.errors.full_messages
      flash.now[:error] = t ".fail"
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to lawyer_articles_path
  end

  private
  def article_params
    params.require(:article).permit Article::ARTICLE_ATTRIBUTES
  end

  def article
    return if params[:id].nil?
    article = current_account.articles.find params[:id]
    unless current_account == article.account
      flash[:error] = t ".access_denies"
      redirect_to root_path
    end
  end
end
