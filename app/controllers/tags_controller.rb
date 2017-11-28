class TagsController < ApplicationController

  def show
  	tag = Tag.find(params[:id])  
    @articles = Article.tagged_with(tag.name).page(params[:page])
      .per Settings.article.top_page.per
     @questions = Question.tagged_with(tag.name).page(params[:page])
      .per Settings.article.top_page.per
    @tag_text = tag.name
  end

end
