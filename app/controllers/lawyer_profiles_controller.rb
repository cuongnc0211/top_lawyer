class LawyerProfilesController < ApplicationController
  def show
    @lawyer_profile = LawyerProfile.find params[:id]
  end
end
