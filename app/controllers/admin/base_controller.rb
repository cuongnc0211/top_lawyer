class BaseController < ApplicationController
  before_action :authenticate_user!, :authenticate_admin

  private
  def authenticate_admin
    redirect_to root_path unless current_account.Admin?
  end
end
