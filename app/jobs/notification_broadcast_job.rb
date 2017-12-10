class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notify)
    ActionCable.server.broadcast "notifications_channel", message: notify.id
  end

  private
  def render_notification notify
    ApplicationController.renderer.render(partial: 'shared/notifies/notify', locals: { notify: notify })
  end
end
