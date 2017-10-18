class ApplicationController < ActionController::Base
  helper ApplicationHelper
  layout "application"

  protect_from_forgery with: :exception
end
