class One2OneChannel < ApplicationCable::Channel
  ONE2ONE_CHANNEL_NAME = 'ONE2ONE_%s'
  def subscribed
    stream_from One2OneChannel.channel_key_name(current_user)
  end

  def self.channel_key_name(user)
    username = user.respond_to?(:username) ? user.username : user
    format(ONE2ONE_CHANNEL_NAME, username)
  end
end
