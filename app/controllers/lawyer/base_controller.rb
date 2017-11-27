class Lawyer::BaseController < ApplicationController
  layout "lawyer"
  helper LawyerHelper
  before_action :authenticate_account!, :authenticate_lawyer

  private
  def authenticate_lawyer
  	flash[:danger] = t ".access_denies"
    redirect_to root_path unless (current_account.Lawyer || current_account.Admin)?
  end
end
