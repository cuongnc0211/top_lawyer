class QuestionsController < ApplicationController
  impressionist actions: [:show], unique: [:session_hash]
  
  def index
    @questions = Question.all.order(created_at: :desc).page(params[:page])
      .per Settings.article.top_page.per
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
    @comment = Comment.new
  end
end
