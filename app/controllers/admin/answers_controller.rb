class Admin::AnswersController < Admin::BaseController
  def index
  	search_content = params[:q]
    @answers = Answer.search(content_cont: search_content).result(distinct: true)
      .page(params[:page]).per Settings.search.per_page.default
  end

  def destroy
    @answer = Answer.find(params[:id])
  end
end
