class SystemMailer < ApplicationMailer
  def send_alert_over_mail_quota(current_number_mails)
    @current_number_mails = current_number_mails
    mail to: ENV['ADMIN_EMAIL'], subject: '[Anychat-System] Mail quote over!'
  end
end
