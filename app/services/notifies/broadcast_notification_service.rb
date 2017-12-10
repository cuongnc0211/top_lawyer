class Notifies::BroadcastNotificationService
  attr_reader :notify

  def initialize notify
    @notify = notify
  end

  def perform
    ActionCable.server.broadcast "notifications_channel_#{notify.target_id}", message: render_notification(notify)
  end

  private
  def render_notification notify
    ApplicationController.renderer.render(partial: 'shared/notifies/notify', locals: { notify: notify })
  end
end
