class TagsController < ApplicationController

  def show
    @articles = Article.tagged_with params[:id]
    @tag_text = params[:id]
  end

end
