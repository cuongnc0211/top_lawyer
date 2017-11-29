class QuestionsController < ApplicationController
  impressionist actions: [:show], unique: [:session_hash]

  def index
    @questions = Question.all.order(created_at: :desc).page(params[:page])
      .per Settings.article.top_page.per
    @top_lawyers ||= Account.top_lawyer Settings.ranking.top_page
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.order(total_vote: :desc)
    @comment = Comment.new
    @top_tags = ActsAsTaggableOn::Tag.most_used(10)
    @related_questions = @question.related_questions

    if current_account.present?
      @vote = @question.init_vote(current_account.id)
    end
  end
end
