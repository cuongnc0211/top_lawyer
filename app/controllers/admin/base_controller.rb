class Admin::BaseController < ApplicationController
  before_action :authenticate_user!, :authenticate_admin

  private
  def authenticate_admin
  	flash[:danger] = t ".access_denies"
    redirect_to root_path unless current_account.Admin?
  end
end
