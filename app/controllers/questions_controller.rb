class QuestionsController < ApplicationController

  def index
    @questions = Question.all.page(params[:page]).per Settings.article.top_page.per
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
    @comment = Comment.new
  end
end
