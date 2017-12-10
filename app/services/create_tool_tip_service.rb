class CreateToolTipService
  include ActionView::Helpers::TextHelper
  attr_reader :article, :tags

  def initialize article, tags
    @article = article
    @tags = tags
  end

  def perform
    content = ActionController::Base.helpers.strip_tags(article.content)
    tags.each do |tag|
      string = "<span class='tooltip_body' data-toggle='tooltip' title='#{tag.tag_descriptions.last.content}'>#{tag.name}</span>"
      content = content.gsub(tag.name, string)
    end
    article.content = content
    article.save
  end
end
