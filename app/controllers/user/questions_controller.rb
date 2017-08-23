class User::QuestionsController < User::BaseController
  before_action :question, only: [:edit, :update]

  def new
    @question = Question.new
    @categories = Category.all
  end
  
  def index
    @questions = current_account.questions
  end
  
  def edit
    @categories = Category.all
  end 

  def create
    @question = current_account.questions.new(question_params)
    if @question.save
      redirect_to  new_user_question_path, notice: "Your question was created successfully"
    else
      flash.now[:alert] = "Please correct the form"
      render :new
    end
  end

  def update
    question = current_account.questions.build
    if@question.update_attributes question_params
      flash[:success] = t ".updated"
      redirect_to root_path
    else
      flash[:error] = t ".fail"
      render :edit
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
