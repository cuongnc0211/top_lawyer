class Admin::AccountsController < Admin::BaseController
  def index
    search_content = params[:q]
    @accounts = Account.search(email_or_name_cont: search_content).result(distinct: true)
      .page(params[:page]).per Settings.search.per_page.default
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
