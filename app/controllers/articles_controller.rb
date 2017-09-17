class ArticlesController < ApplicationController
  #before_action :article, only: [:edit, :update, :destroy, :show]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @commentable = @article
    @comments = @commentable.comments.hash_tree(limit_depth: 5)
    @comment = Comment.new
    if params[:parent_id] != nil
      @reply = @commentable.comments.new(parent_id: params[:parent_id])
    end
  end

  def new
    @article = Article.new
    @categories = Category.all
  end

  def edit
    @article = Article.find(params[:id])
    @categories = Category.all
  end

  def create
    @categories = Category.all
    @article = current_account.articles.new(article_params)
    if @article.save
      redirect_to articles_path
      flash[:success] = t ".new"
    else
      puts @article.errors.full_messages
      flash.now[:alert] = t "Please_correct_the_form"
      render :new
    end
  end

  def update
    if @article.update_attributes article_params
      flash[:success] = t ".updated"
      redirect_to articles_path
    else
      puts @article.errors.full_messages
      flash.now[:error] = t ".fail"
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit Article::ARTICLE_ATTRIBUTES
  end

  # def article
  #   @article = current_account.articles.find params[:id]
  #   unless current_account == @article.account
  #     flash[:error] = t ".access_denies"
  #     redirect_to root_path
  #   end
  # end
end
