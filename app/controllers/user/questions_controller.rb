class User::QuestionsController < User::BaseController
  before_action :question, only: [:edit, :update, :destroy]

  def new
    @question = Question.new
    @categories = Category.all
    @tags = Tag.all.where.not(name: @question.tags.pluck(:name))
    gon.tags = @question.tags.pluck(:name)
  end

  def index
    @questions = current_account.questions.order(created_at: :desc).page(params[:page])
      .per Settings.article.top_page.per
  end

  def edit
    @categories = Category.all
    @tags = Tag.all.where.not(name: @question.tags.pluck(:name))
    gon.tags = @question.tags.pluck(:name)
  end

  def create
    @question = current_account.questions.new(question_params)
    if @question.save
      redirect_to  user_questions_path
      flash[:success] = t ".updated"
    else
      flash.now[:alert] = t ".fail"
      render :new
    end
  end

  def update
    question = current_account.questions.build
    if@question.update_attributes question_params
      flash[:success] = t ".updated"
      redirect_to user_questions_path
    else
      flash[:error] = t ".fail"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to user_questions_path
      flash[:success] = t ".updated"
    else
      redirect_to user_questions_path
      flash[:error] = t ".fail"
    end
  end

  private
  def question_params
    params.require(:question).permit Question::QUESTION_ATTRIBUTES
  end

  def question
    @question = Question.find params[:id]
    unless current_account == @question.account
      flash[:error] = t ".access_denies"
      redirect_to root_path
    end
  end
end
