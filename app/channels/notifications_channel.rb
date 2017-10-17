class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    account_id = params[:account_id]
    reject if account_id.nil?
    stream_from "notifications_channel_#{account_id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def received

  end
end
