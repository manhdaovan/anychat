class MessagesController < ApplicationController
  include BeforeActionTrigger
  before_action :require_login, :store_next_url

  def index
    @online = online?(params.fetch(:username, ''))
  end

  def create
    @msg = Message.new(create_message_params)
    if create_message_params.fetch(:username, nil) != current_user.username
      @msg.errors.add(:from_user, 'invalid')
    end
    return unless @msg.valid?

    # Mark user online again when user idles over 90 minutes then comes back
    write_user2cache(current_user.username, current_user.id) unless online?(session[:username])

    @receiver_online = online?(@msg.to_user)
    if @receiver_online
      ActionCable.server.broadcast(One2OneChannel.channel_key_name(@msg.to_user),
                                   type:    'message', from_user: current_user.username,
                                   to_user: @msg.to_user, msg: @msg.msg_content)
    else
      user = user_instance(@msg.to_user)
      send_offline_msg(user, @msg) if user.present?
    end
  end

  private

  def user_instance(username)
    User.find_by(username: username)
  end

  def send_offline_msg(to_user, msg)
    if under_mail_quota
      if to_user.receive_offline_msg?
        MessageMailer.send_offline_message(to_user.email, msg)
        update_number_emails
      end
    else
      unless sent_alert_over_email?
        send_alert_over_mail_quota(current_number_mails)
        mark_send_alert_over
      end
    end
  end

  def create_message_params
    params.require(:message).permit(:from_user, :to_user, :msg_content)
  end
end
