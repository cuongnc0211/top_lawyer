class Admin::UsersController < Admin::BaseController
  def index
    Account.User.order :created_at, :desc
  end
end
