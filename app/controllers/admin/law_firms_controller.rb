class Admin::LawFirmsController < Admin::BaseController
  before_action :law_firm, only: :update

  def index
    search_content = params[:q]
    @law_firms = LawFirm.search(name_or_phone_number_or_fax_or_email_or_address_or_introduction_cont: search_content)
      .result(distinct: true).page(params[:page]).per Settings.search.per_page.default
  end

  def update
    if @law_firm.update_attributes is_active: params[:law_firm][:is_active]
      redirect_to admin_law_firms_path
      flash[:success] = t ".updated"
    else
      redirect_to admin_law_firms_path
      flash[:error] = t ".fail"
    end
  end

  private
  def law_firm
    @law_firm = LawFirm.find params[:id]
  end
end
