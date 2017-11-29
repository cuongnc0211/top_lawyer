class Lawyer::AnswersController < Lawyer::BaseController

  def new
    @answer = Question.find(params[:question_id]).answers.build
  end

  def create
    @answer = Answer.new lawyer_answer_params
    @answer.account_id = current_account.id
    if @answer.save
      flash[:success] = t ".created"
      ::Notifies::CreateNotificationService.new(current_account: current_account,
        target_account: @answer.question.account, model: @answer.question, action: :answer_question).perform
      redirect_to (params[:answer][:from_page].nil?) ? lawyer_questions_path : question_path(@answer.question)
    else
      flash.now[:error] = t ".create_fail"
      render :new
    end
  end

  private
  def lawyer_answer_params
    params.require(:answer).permit Answer::ANSWER_ATTRIBUTES
  end
end
