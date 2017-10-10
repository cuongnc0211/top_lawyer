class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
    @comment = Comment.new
    if params[:parent_id] != nil
      sub_answer = Answer.find_by_id(Comment.find_by_id(params[:parent_id]).commentable_id)
      @reply = sub_answer.comments.new(parent_id: params[:parent_id])
    end
  end
end
