class User::CommentsController < User::BaseController
  def update
    @comment = Comment.find params[:id]
    if @comment.update_attributes comment_params
      flash.now[:success] = t ".updated"
    else
      flash.now[:success] = t ".update_fail"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @comment = Comment.find params[:id]
    if @comment.destroy
      flash.now[:success] = t ".deleted"
    else
      flash.now[:success] = t ".delete_fail"
    end
    redirect_back(fallback_location: root_path)
  end

  private
  def comment_params
    params.require(:comment).permit :content
  end
end
