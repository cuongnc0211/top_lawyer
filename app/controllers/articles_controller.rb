class ArticlesController < ApplicationController
  impressionist actions: [:show], unique: [:impressionable_type, :impressionable_id, :session_hash]

  def index
    redirect_to root_path
  end

  def show
    @article = Article.find(params[:id])
    @article = CreateToolTipService.new(@article, @article.all_tags).perform
    impressionist @article
    @author_articles = @article.account.articles.where.not(id: @article.id)
      .order(total_vote: :desc).limit(Settings.article.related)
    @related_articles = @article.related_articles
    @advertise_lawyers = Kaminari.paginate_array(Account.advertise_lawyer @article.category_id)
      .page(params[:page]).per Settings.advertise_number.category

    if current_account.present?
      @vote = @article.init_vote(current_account.id)
      @clip = @article.init_clip(current_account.id)
    end

    @commentable = @article
    @comments = @commentable.comments.hash_tree(limit_depth: 5)
    @comment = Comment.new
    if params[:parent_id] != nil
      @reply = @commentable.comments.new(parent_id: params[:parent_id])
    end
  end
end
