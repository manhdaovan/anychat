class MessageMailer < ApplicationMailer
  def send_offline_message(to_user_email, msg)
    @msg = msg
    mail to: to_user_email, subject: '[Anychat] Offline Message'
  end
end
