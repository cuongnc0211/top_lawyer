class User::AccountsController < User::BaseController
  before_action :account, only: [:edit, :update]

  def index
  end

  def edit
  end

  def update
    if @account.update_attributes account_params
      flash[:success] = t ".updated"
      redirect_to root_path
    else
      flash[:error] = t ".update_fail"
      render :edit
    end
  end

  private
  def account_params
    params.require(:account).permit Account::ACCOUNT_ATTRIBUTES
  end

  def account
    @account = Account.find params[:id]
    unless current_account == @account
      flash[:error] = t ".access_denies"
      redirect_to root_path 
    end
  end
end
