class Admin::LawyerProfilesController < Admin::BaseController
  before_action :lawyer_profile, only: :update

  def index
    @lawyer_profiles = LawyerProfile.all.page(params[:page]).per Settings.paginate.default
  end

  def update
    if @lawyer_profile.update_attributes is_active: params[:lawyer_profile][:is_active]
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
