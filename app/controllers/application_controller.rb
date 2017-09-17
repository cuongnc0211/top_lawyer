class ApplicationController < ActionController::Base
  helper ApplicationHelper

  protect_from_forgery with: :exception
end
