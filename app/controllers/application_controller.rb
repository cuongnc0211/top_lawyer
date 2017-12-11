class ApplicationController < ActionController::Base
  helper ApplicationHelper
  layout "application"
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password,
      :password_confirmation, :name])
  end

  def after_sign_in_path_for(resource)
    if resource.sign_in_count > 1
      super
    else
      follows_follow_categories_path
      # stored_location_for(resource) || request.referer || root_path
    end
  end
end
