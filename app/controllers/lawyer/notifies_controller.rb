class Lawyer::NotifiesController < Lawyer::BaseController
  def index
    @notifies = current_account.notified
  end
end
