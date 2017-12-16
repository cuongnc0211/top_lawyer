class User::ReviewsController < User::BaseController
  def create
    @review = Review.new review_params
    @review.account_id = current_account.id
    if @review.save
      flash[:success] = t ".created"
    else
      flash[:errors] = t ".create_fail"
    end
    redirect_back(fallback_location: root_path)
  end

  private
  def review_params
    params.require(:review).permit :reviewable_type, :reviewable_id, :content
  end
end
