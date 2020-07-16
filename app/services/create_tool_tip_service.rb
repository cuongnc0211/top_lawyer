class CreateToolTipService
  include ActionView::Helpers::TextHelper
  attr_reader :article, :tags

  def initialize article, tags
    @article = article
    @tags = tags
  end

  def perform
    content = sanitize(article.content)
    tags.each do |tag|
      unless tag.tag_descriptions.nil?
        string = "<span class='tooltip_body' data-toggle='tooltip' title='#{tag&.tag_descriptions&.last&.content}'><i>#{tag&.name}</i></span>"
        content.gsub!(tag.name, string)
      end
    end
    article.content = content
    article
  end
end
