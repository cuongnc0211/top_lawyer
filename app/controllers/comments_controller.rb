class CommentsController < ApplicationController
  before_action :load_commentable

  def new
    if @commentable.instance_of?(Article)
      redirect_to article_path(@commentable, parent_id: params[:parent_id])
    end
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
      create_notify @comment
      if @resource == "articles"
        redirect_to article_path(@commentable)
        flash[:success] = t ".new"
      end
      if @resource == "answers"
        redirect_to question_path(@commentable.question)
        flash[:success] = t ".new"
      end
    else
      flash.now[:alert] = t ".comment_error"
      render :new
    end
  end

  private
  def load_commentable
    @resource, id = request.path.split('/')[1,2]
    @commentable = @resource.singularize.classify.constantize.find(id)
  end

  def comment_params
    params.require(:comment).permit!
  end

  def create_notify comment
    if comment.parent_id.nil?
      model = comment.commentable
      action = ("comment_" + comment.commentable_type.downcase).to_sym
    else
      model = comment.parent
      action = :reply_comment
    end
    ::Notifies::CreateNotificationService.new(current_account: current_account,
      target_account: model.account, model: model, action: action).perform
  end
end
