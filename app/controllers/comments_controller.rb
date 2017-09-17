class CommentsController < ApplicationController
  before_action :load_commentable

  def new
    redirect_to article_path(@commentable, parent_id: params[:parent_id])
  end

  def create
    if params[:comment][:parent_id].to_i > 0
      parent = Comment.find_by_id(params[:comment].delete(:parent_id))
      @comment = parent.children.build(comment_params)
      @comment.account = current_account
      @comment.commentable_id = parent.commentable_id
      @comment.commentable_type = parent.commentable_type
    else
      @comment = @commentable.comments.new(comment_params)
      @comment.account = current_account
    end

    if @comment.save
      redirect_to article_path(@commentable)
      flash[:success] = t ".new"
    else
      flash.now[:alert] = t ".comment_error"
      render :new
    end
  end

  private
  def load_commentable
    resource, id = request.path.split('/')[1,2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def comment_params
    params.require(:comment).permit!
  end
end
