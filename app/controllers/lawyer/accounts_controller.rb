class Lawyer::AccountsController < Lawyer::BaseController
  def show
    @account = current_account
  end

  def edit
    @account = current_account
  end

  def update
    if current_account.update_attributes account_params
      flash[:success] = t ".updated"
      redirect_to lawyer_root_path
    else
      flash.now[:errors] = t ".update_fail"
      render :edit
    end
  end

  private
  def account_params
    params.require(:account).permit Account::ACCOUNT_ATTRIBUTES
  end
end
