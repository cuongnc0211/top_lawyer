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
    ::CreateHistoryPointService.new(point: Point.answer.first, account: @answer.account).perform
    ::UpdatePointLawyerService.new( @answer.account.lawyer_profile).perform
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update_attributes lawyer_answer_params
      flash[:success] = t ".updated"
      redirect_back(fallback_location: root_path)
    else
      flash[:errors] = t ".update_fail"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if @answer.destroy
      flash[:success] = t ".deleted"
      redirect_back(fallback_location: root_path)
    else
      flash[:errors] = t ".delete_fail"
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def lawyer_answer_params
    params.require(:answer).permit Answer::ANSWER_ATTRIBUTES
  end

  def author_lawyer
    unless current_account.id == answer.account_id
      flash[:errors] = t ".access_denies"
      redirect_back(fallback_location: root_path)
    end
  end
end
