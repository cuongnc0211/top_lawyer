class QuestionsController < ApplicationController
  impressionist actions: [:show], unique: [:impressionable_type, :impressionable_id, :session_hash]

  def index
    questions = Questions::NewFeedService.new(current_account).perform()
    @questions = Kaminari.paginate_array(questions).page(params[:page])
      .per Settings.article.top_page.per
    @top_lawyers ||= Account.top_lawyer Settings.ranking.top_page
    @top_tags = ActsAsTaggableOn::Tag.most_used(10)
  end

  def show
    @question = Question.find(params[:id])
    impressionist @question
    @answers = @question.answers.order(total_vote: :desc)
    @comment = Comment.new
    @top_tags = ActsAsTaggableOn::Tag.most_used(10)
    @related_questions = @question.related_questions

    if current_account.present?
      @vote = @question.init_vote(current_account.id)
    end
  end
end
