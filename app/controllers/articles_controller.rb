class ArticlesController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    @article = Article.find(params[:id])
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
