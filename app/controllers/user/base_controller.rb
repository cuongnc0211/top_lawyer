class User::BaseController < ApplicationController
  before_action :authenticate_account!
end
