class Lawyer::QuestionsController < Lawyer::BaseController
  before_action :question, only: [:edit, :update, :destroy]
  
  def index
    @questions = Question.all.page(params[:page]).per Settings.per_page.default
  end
  
  private
  def question_params
    params.require(:question).permit Question::QUESTION_ATTRIBUTES
  end

  def question
    @question = Question.find params[:id]
  end
end
