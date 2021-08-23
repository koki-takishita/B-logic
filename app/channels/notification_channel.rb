class NotificationChannel < ApplicationCable::Channel
  # クライアントと接続された時
  def subscribed
    # stream_from "some_channel"
    stream_from 'notification_channel'
  end

  # 接続が解除された時
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def post(data)
    ActionCable.server.broadcast('notification_channel', data)
  end
end
