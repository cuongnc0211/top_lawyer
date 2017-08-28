class Admin::BaseController < ApplicationController
  before_action :authenticate_account!, :authenticate_admin
  layout "admin"

  private
  def authenticate_admin
  	flash[:danger] = t ".access_denies"
    redirect_to root_path unless current_account.Admin?
  end
end
