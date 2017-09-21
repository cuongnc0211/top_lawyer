class User::AccountsController < User::BaseController
  before_action :account, only: [:edit, :update]

  def edit
  end

  def update
    if @account.update_attributes account_params
      flash[:success] = t ".updated"
      redirect_to user_root_path
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
    @account = current_account
  end
end
