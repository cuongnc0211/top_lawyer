class Lawyer::LawFirmsController < Lawyer::BaseController
  before_action :law_firm, only: [:edit, :update]

  def new
    @law_firm = current_account.law_firm || LawFirm.new
    @image = @law_firm.images.build
    @provinces = Province.all
  end

  def create
    @provinces = Province.all
    @law_firm = current_account.lawyer_profile.build_law_firm law_firm_params
    if @law_firm.save && update_lawyer
      flash[:success] = t ".created"
      redirect_to law_firm_path(@law_firm)
    else
      flash.now[:errors] = t ".create_fail"
      render :new
    end
  end

  def edit
    @law_firm = current_account.law_firm
    @provinces = Province.all
  end

  def update
    @provinces = Province.all
    if @law_firm.update_attributes(law_firm_params)
      flash[:success] = t ".updated"
      redirect_to law_firm_path(@law_firm)
    else
      flash.now[:errors] = t ".update_fail"
      render :edt
    end
  end

  private
  def law_firm_params
    params.require(:law_firm).permit LawFirm::LAWFIRM_ATTRIBUTES
  end

  def law_firm
    if current_account.manager_of params[:id]
      @law_firm = current_account.law_firm
    else
      flash[:errors] = t ".access_denies"
      redirect_to lawyer_root_path
    end
  end

  def update_lawyer
    current_account.lawyer_profile.update_attributes is_manager: true, law_firm_id: @law_firm.id
  end
end
