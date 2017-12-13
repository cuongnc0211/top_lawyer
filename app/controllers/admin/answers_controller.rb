class Admin::AnswersController < Admin::BaseController
  def index
    @answers = Answer.all.page(params[:page]).per Settings.paginate.default
  end

  def destroy
    @answer = Answer.find(params[:id])
  end
end
