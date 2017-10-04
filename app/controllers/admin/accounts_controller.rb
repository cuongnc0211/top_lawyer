class Admin::AccountsController < Admin::BaseController
  def index
    @accounts = Account.User.page(params[:page]).per Settings.paginate.default
  end

  def update
    @account = Account.find params[:id]
    if @account.update_attributes is_active: params[:account][:is_active]
      flash[:success] = t ".updated"
      redirect_to admin_accounts_path
    else
      flash[:errors] = t ".update_fail"
      redirect_to admin_accounts_path
    end
  end
end
