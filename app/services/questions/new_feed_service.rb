class Questions::NewFeedService
  attr_reader :current_account

  def initialize current_account = nil
    @current_account = current_account
  end

  def perform
    all_category_id = Category.all.pluck(:id)
    if current_account.nil?
      @questions = Question.all_feed
    else
      user_category_ids = current_account.categories.pluck(:id)
      @questions = Question.new_feed(user_category_ids)
      @questions += Question.new_feed(all_category_id - user_category_ids)
    end
  end
end
