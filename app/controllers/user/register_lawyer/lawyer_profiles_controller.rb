class User::RegisterLawyer::LawyerProfilesController < User::BaseController
  def new
    @lawyer_profile = current_account.lawyer_profile || current_account.build_lawyer_profile
  end

  def create
    @lawyer_profile = current_account.build_lawyer_profile lawyer_profile_params
    default_attributes
    if @lawyer_profile.save
      flash[:success] = t ".created"
      redirect_to user_root_path
    else
      flash.now[:errors] = t ".create_fail"
      render :new
    end
  end

  def update
    @lawyer_profile = LawyerProfile.find params[:id]
    if @lawyer_profile.update_attributes lawyer_profile_params
      flash[:success] = t ".updated"
      redirect_to user_root_path
    else
      flash.now[:errors] = t ".update_fail"
      render :edit
    end
  end

  private
  def lawyer_profile_params
    params.require(:lawyer_profile).permit LawyerProfile::LAWYER_PROFILE_ATTRIBUTES
  end

  def default_attributes
    @lawyer_profile.is_active = false
    @lawyer_profile.approved = false
  end
end
