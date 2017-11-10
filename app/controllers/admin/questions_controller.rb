class Admin::QuestionsController < Admin::BaseController
  def index
    @questions = Kaminari.paginate_array(Question.all.reverse).page(params[:page]).per Settings.paginate.default
  end

  def destroy
    @question = Question.find params[:id]
    if @question.destroy
      flash[:success] = t ".deleted"
      redirect_to admin_questions_path
    else
      flash[:error] = t ".delete_fail"
      redirect_to admin_questions_path
    end
  end
end
