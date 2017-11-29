class Lawyer::LawFirmMembersController < Lawyer::BaseController

  def index
    current_law_firm_id = LawyerProfile.find_by(account_id: current_account).law_firm_id
    current_law_firm = LawFirm.find(current_law_firm_id)
    if params[:q].present?
      @lawyer_profiles =LawyerProfile.no_law_firm.not_add_law_firm(current_law_firm.in_adding)
        .search(account_name_or_account_email_or_lawyer_id_or_address_or_phone_number_or_fax_number_or_introduction_cont: params[:q])
          .result(distinct: true).page(params[:page]).per Settings.search.per_page.default
    end
    @members = LawyerProfile.where(law_firm_id: current_law_firm_id, is_manager: 0)
      .page(params[:page]).per Settings.search.per_page.default
  end

  def show
  end

  def destroy
    if LawyerProfile.find(params[:id]).update_attributes(law_firm_id: nil)
      flash[:success] = t ".remove"
      redirect_to lawyer_law_firm_members_path(current_account)
    end
  end

end
