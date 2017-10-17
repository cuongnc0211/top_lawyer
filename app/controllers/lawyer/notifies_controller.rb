class Lawyer::NotifiesController < Lawyer::BaseController
  def index
    @notifies = Notify.all.reverse
  end
end
