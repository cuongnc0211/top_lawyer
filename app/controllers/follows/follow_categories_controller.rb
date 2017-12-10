class Follows::FollowCategoriesController < User::BaseController
  layout "application"

  def index
    @categories = Category.all
  end

  def create
    category_id = params[:follow_category][:category_id].to_i
    @follow_category = FollowCategory.new account_id: current_account.id, category_id: category_id
    @category = Category.find(category_id)
    if @follow_category.save
      respond_to{|format| format.js}
    else
      flash.now[:error] = t ".failed"
    end
  end

  def destroy
    category_id = params[:follow_category][:category_id].to_i
    @category = Category.find(category_id)
    @follow_category = FollowCategory.find params[:id]
    if @follow_category.destroy
      respond_to{|format| format.js}
    end
  end
end
