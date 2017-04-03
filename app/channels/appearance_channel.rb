class AppearanceChannel < ApplicationCable::Channel
  ONLINE_CHANNEL_NAME = 'online_channel'.freeze

  def subscribed
    stream_from ONLINE_CHANNEL_NAME
    ActionCable.server.broadcast(ONLINE_CHANNEL_NAME, type: 'online', username: current_user.username)
    store_user_info(current_user.username, false)
  end

  def unsubscribed
    clear_cable_user_info(current_user.username)
    ActionCable.server.broadcast(ONLINE_CHANNEL_NAME, type: 'offline', username: current_user.username)
  end
end
