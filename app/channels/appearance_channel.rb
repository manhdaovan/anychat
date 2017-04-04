class AppearanceChannel < ApplicationCable::Channel
  ONLINE_CHANNEL_NAME = 'online_channel'.freeze

  def subscribed
    stream_from ONLINE_CHANNEL_NAME
    ActionCable.server.broadcast(ONLINE_CHANNEL_NAME,
                                 type:          'online',
                                 username:      current_user.username,
                                 lock_send_msg: !current_user.receive_offline_msg?)
    write_user2cache(current_user.username, current_user.id)
  end

  def unsubscribed
    Rails.cache.delete(current_user.username)
    ActionCable.server.broadcast(ONLINE_CHANNEL_NAME,
                                 type:          'offline',
                                 username:      current_user.username,
                                 lock_send_msg: !current_user.receive_offline_msg?)
  end
end
