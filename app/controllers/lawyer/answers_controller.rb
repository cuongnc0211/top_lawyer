class Lawyer::AnswersController < Lawyer::BaseController

  def new
    @answer = Question.find(params[:question_id]).answers.build
  end

  def create
    @answer = Answer.new(lawyer_answer_params)
    @answer.account_id = current_account.id
    if @answer.save
      flash[:success] = t ".updated"
      redirect_to lawyer_questions_path
    else
      flash.now[:error] = t ".fail"
      render :new
    end
  end

  private
  def lawyer_answer_params
    params.require(:answer).permit Answer::ANSWER_ATTRIBUTES
  end
end
