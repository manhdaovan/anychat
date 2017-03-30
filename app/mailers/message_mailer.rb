class MessageMailer < ApplicationMailer
  def send_offline_message(from_user, to_user, msg_content)
    @from_user = from_user
    @to_user = to_user
    @msg_content = msg_content
    mail to: @to_user.email, subject: '[Anychat] Offline Message'
  end
end
