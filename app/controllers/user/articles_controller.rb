class User::ArticlesController < User::BaseController
  before_action :article, only: [:edit, :update]

  def index
    @articles = current_account.articles
  end

  def new
    @article = Article.new
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

  def create
    @categories = Category.all
    @article = current_account.articles.new(article_params)
    if @article.save
      redirect_to  new_user_article_path, notice: "Your article was created successfully"
    else
      puts @article.errors.full_messages
      flash.now[:alert] = "Please correct the form"
      render :new
    end
  end

  def update
    if @article.update_attributes article_params
      flash[:success] = t ".updated"
      redirect_to user_articles_path
    else
      puts @article.errors.full_messages
      flash[:error] = t ".fail"
      render :edit
    end
  end

  private
    def article_params
      params.require(:article).permit Article::ARTICLE_ATTRIBUTES
    end

  def article
      @article = Article.find params[:id]
      unless current_account == @article.account
        flash[:error] = t ".access_denies"
        redirect_to root_path
      end
  end
end
