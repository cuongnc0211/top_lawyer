class CategoriesController < ApplicationController
  def show
    @category = Category.find params[:id]
    @articles = @category.articles.page(params[:page]).per 8
    @questions = @category.questions.page(params[:page]).per 8
    @advertise_lawyers = Kaminari.paginate_array(Account.advertise_lawyer @category.id)
      .page(params[:page]).per Settings.advertise_number.category
  end

  def index
    @categories = Category.all
  end
end
