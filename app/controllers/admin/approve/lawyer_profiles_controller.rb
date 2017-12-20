class Admin::Approve::LawyerProfilesController < Admin::BaseController
  before_action :lawyer_profile, only: :update

  def show
    @lawyer_profile = LawyerProfile.find(params[:id])
  end

  def index
    @lawyer_profiles = LawyerProfile.not_approve.page(params[:page]).per Settings.paginate.default
  end

  def update
    if @lawyer_profile.update_attributes is_active: true, approved: true
      @lawyer_profile.account.update_attributes role: :Lawyer
      redirect_to admin_approve_lawyer_profiles_path
      flash[:success] = t ".updated"
    else
      redirect_to admin_approve_lawyer_profiles_path
      flash[:error] = t ".fail"
    end
  end

  private
  def lawyer_profile
    @lawyer_profile = LawyerProfile.find params[:id]
  end
end
