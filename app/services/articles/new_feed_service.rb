class Articles::NewFeedService
  attr_reader :current_account

  def initialize current_account = nil
    @current_account = current_account
  end

  def perform
    all_category_id = Category.all.pluck(:id)
    if current_account.nil?
      @articles = Article.all_feed
    else
      user_category_ids = current_account.categories.pluck(:id)
      @articles = Article.publish.new_feed(user_category_ids)
      @articles += Article.publish.new_feed(all_category_id - user_category_ids)
    end
  end
end
