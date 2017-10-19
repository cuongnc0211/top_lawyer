class ArticlesController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    @article = Article.find(params[:id])
    @vote = @article.init_vote(current_account.id) if current_account.present?
    @commentable = @article
    @comments = @commentable.comments.hash_tree(limit_depth: 5)
    @comment = Comment.new
    if params[:parent_id] != nil
      @reply = @commentable.comments.new(parent_id: params[:parent_id])
    end
  end
end
