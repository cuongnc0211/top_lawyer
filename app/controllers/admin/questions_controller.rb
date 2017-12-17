class Admin::QuestionsController < Admin::BaseController
  def index
    search_content = params[:q]
    @questions = Question.search(title_or_content_cont: search_content).result(distinct: true)
      .page(params[:page]).per Settings.search.per_page.default
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
