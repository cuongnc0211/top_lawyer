class SuggestController < ApplicationController
	def index
    @article = Article.all
    respond_to do |format|
      format.html
      format.json{ render json: @article }
    end
  end
end