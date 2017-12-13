class User::NotifiesController < User::BaseController
  before_action :notify, only: :update

  def update
    @notify.update_attributes(status: :read)
    send_to @notify
  end

  private
  def notify
    @notify = Notify.find(params[:id])
  end

  def send_to notify
    notifyable = @notify.notifyable

    case notify.notifyable_type
    when "Article", "Question"
      redirect_to polymorphic_path(notifyable)
    when "Answer"
      redirect_to question_path(notifyable.question)
    when "Comment"
      redirect_to polymorphic_path(notifyable.commentable)
    end
  end
end
