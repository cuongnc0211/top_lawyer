class TopPagesController < ApplicationController
  def index
    @articles = Article.all.page(params[:page]).per Settings.article.top_page.per
    @top_page = TopPage.new
    @top_tags = ActsAsTaggableOn::Tag.most_used(10)
  end
end
