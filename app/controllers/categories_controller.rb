class CategoriesController < ApplicationController
  def show
    @category = Category.find params[:id]
    @articles = @category.articles.page(params[:page]).per 8
    @questions = @category.questions.page(params[:page]).per 8
  end

  def index
    @categories = Category.all
  end
end
