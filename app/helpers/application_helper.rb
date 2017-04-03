module ApplicationHelper
  def redirect_back_or(path)
    redirect_to session[:forward_url] || path
  end

  def store_user_info(user, save_to_session = true)
    cache_key   = user.respond_to?(:username) ? user.username : user
    cache_value = user.respond_to?(:username) ? user.id : user
    write_user2cache(cache_key, cache_value)
    session[:username]        = cache_key if save_to_session
    cookies.signed[:username] = cache_key
  end

  def clear_cable_user_info(username)
    cookies.delete(:username)
    Rails.cache.delete(username)
  end

  def write_user2cache(username, value)
    Rails.cache.write(username, value)
  end

  def online?(user)
    cache_key = user.respond_to?(:username) ? user.username : user
    Rails.cache.read(cache_key).present?
  end

  def offline?(user)
    cache_key = user.respond_to?(:username) ? user.username : user
    Rails.cache.read(cache_key).blank?
  end

  def current_user
    @current_user ||= begin
      User.find_by(username: session[:username])
    end
  end

  def logout_user
    current_user.update(last_logged_in: Time.zone.now.to_s) if current_user
    username = session.delete(:username)
    cookies.delete(:username)
    Rails.cache.delete(username) if username
  end

  def mail_quota_key
    "mail-quota-#{Time.current.year}-#{Time.current.month}"
  end

  def mail_alert_over_key
    "mail-over-#{Time.current.year}-#{Time.current.month}"
  end

  def update_number_emails
    Rails.cache.write(mail_quota_key,
                      current_number_mails + 1,
                      expires_in: 1.month)
  end

  def sent_alert_over_email?
    Rails.cache.read(mail_alert_over_key).present?
  end

  def mark_send_alert_over
    Rails.cache.write(mail_alert_over_key,
                      Time.zone.now.to_s,
                      expires_in: 1.month)
  end

  def current_number_mails
    Rails.cache.read(mail_quota_key).to_i
  end

  def under_mail_quota
    max_quota = ENV['MAILGUN_QUOTA'].to_i
    current_number_mails < max_quota - 1000 # buffer 500
  end

  def sent_offline_key(from_user, to_user)
    "sent-offline-#{from_user.username}-#{to_user.username}"
  end

  def sent_first_offline_msg?(from_user, to_user)
    Rails.cache.read(sent_offline_key(from_user, to_user)).present?
  end

  def clear_sent_first_msg(from_user, to_user)
    Rails.cache.delete(sent_offline_key(from_user, to_user))
  end

  def mark_sent_first_offline_msg(from_user, to_user)
    Rails.cache.write(sent_offline_key(from_user, to_user),
                      Time.zone.now.to_s,
                      expires_in: 24.hours)
  end

  def fetch_user(username)
    User.find_by(username: username)
  end
end
