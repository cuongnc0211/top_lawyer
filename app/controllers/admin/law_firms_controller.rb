class Admin::LawFirmsController < Admin::BaseController
  before_action :law_firm, only: :update

  def index
    @law_firms = LawFirm.all.page(params[:page]).per Settings.paginate.default
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
