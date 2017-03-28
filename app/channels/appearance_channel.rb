class AppearanceChannel < ApplicationCable::Channel
  ONLINE_CHANNEL_NAME = 'online_channel'

  def subscribed
    stream_from ONLINE_CHANNEL_NAME
    ActionCable.server.broadcast(ONLINE_CHANNEL_NAME, {type: 'online', username: current_user.username})
    write_user2cache(current_user.username, current_user.id)
  end

  def unsubscribed
    Rails.cache.delete(current_user.username)
    ActionCable.server.broadcast(ONLINE_CHANNEL_NAME, {type: 'offline', username: current_user.username})
  end
end
