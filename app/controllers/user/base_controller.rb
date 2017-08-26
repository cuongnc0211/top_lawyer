class User::BaseController < ApplicationController
  before_action :authenticate_account!
  layout "user"
end
