class Admin::LawyerProfilesController < Admin::BaseController
  before_action :lawyer_profile, only: :update

  def show
    @lawyer_profile = LawyerProfile.find(params[:id])
  end

  def index
    search_content = params[:q]
    @lawyer_profiles =LawyerProfile.search(account_name_or_account_email_or_lawyer_id_or_address_or_phone_number_or_fax_number_or_introduction_cont: search_content)
        .result(distinct: true).page(params[:page]).per Settings.search.per_page.default
  end

  def update
    if @lawyer_profile.update_attributes is_active: params[:lawyer_profile][:is_active], approved: true
      redirect_to admin_lawyer_profiles_path
      flash[:success] = t ".updated"
    else
      redirect_to admin_lawyer_profiles_path
      flash[:error] = t ".fail"
    end
  end

  private
  def lawyer_profile
    @lawyer_profile = LawyerProfile.find params[:id]
  end
end
