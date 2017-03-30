class UserMailer < ApplicationMailer
  def send_active_email(user, token)
    @user = user
    @active_token = token
    mail to: @user.email, subject: '[Anychat] Active Email'
  end
end
