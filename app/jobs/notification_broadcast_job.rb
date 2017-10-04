class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notify)
    ActionCable.server.broadcast "notifications_channel", message: render_notification(notify)
  end

  private
  def render_notification notify
    ApplicationController.renderer.render(partial: 'notifies/notify', locals: { notify: notify })
  end
end
