class Lawyer::BaseController < ApplicationController
  before_action :authenticate_user!, :authenticate_lawyer

  private
  def authenticate_lawyer
  	flash[:danger] = t ".access_denies"
    redirect_to root_path unless current_account.Lawyer?
  end
end
