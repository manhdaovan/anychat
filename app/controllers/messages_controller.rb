class MessagesController < ApplicationController
  include BeforeActionTrigger
  before_action :require_login, :store_next_url

  def index
    @online = online?(params.fetch(:username, ''))
  end

  def create
    @msg = Message.new(create_message_params)
    @msg.errors.add(:from_user, 'invalid') if create_message_params.fetch(:username, nil) != current_user.username
    return unless @msg.valid?

    # Mark user online again when user idles over 90 minutes then comes back
    write_user2cache(current_user.username, current_user.id) unless online?(session[:username])

    @receiver_online = online?(@msg.to_user)
    if @receiver_online
      ActionCable.server.broadcast(One2OneChannel.channel_key_name(@msg.to_user),
                                   {type:    'message', from_user: current_user.username,
                                    to_user: @msg.to_user, msg: @msg.msg_content})
    else
      # TODO: check to_user's email is enabled? and send first message to to_user via email
    end
  end

  private

  def create_message_params
    params.require(:message).permit(:from_user, :to_user, :msg_content)
  end
end
