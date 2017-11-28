class Lawyer::BaseController < ApplicationController
  layout "lawyer"
  helper LawyerHelper
  before_action :authenticate_account!, :authenticate_lawyer

  private
  def authenticate_lawyer
  	flash[:danger] = t ".access_denies"
    unless (current_account.Lawyer? || current_account.Admin?)
      redirect_to root_path
    end
  end
end
