class Lawyer::LawyerProfilesController < Lawyer::BaseController
  before_action :lawyer_profile, only: [:edit, :update]

  def edit
  end

  def update
    if @lawyer_profile.update_attributes lawyer_profile_params
      flash[:success] = t ".updated"
      redirect_to root_path
    else
      flash[:error] = t ".update_fail"
      render :edit
    end
  end

  private
  def lawyer_profile_params
    params.require(:lawyer_profile).permit LawyerProfile::LAWYER_PROFILE_ATTRIBUTES
  end

  def lawyer_profile
    @lawyer_profile = LawyerProfile.find params[:id]
    unless current_account.lawyer_profile == @lawyer_profile
      flash[:error] = t ".access_denies"
      redirect_to root_path 
    end
  end
end
