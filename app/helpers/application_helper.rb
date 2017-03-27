module ApplicationHelper
  def redirect_back_or(path)
    redirect_to session[:forward_url] || path
  end

  def store_user_info(user)
    cache_key   = user.respond_to?(:username) ? user.username : user
    cache_value = user.respond_to?(:username) ? user.id : user
    write_user2cache(cache_key, cache_value)
    session[:username]        = cache_key
    cookies.signed[:username] = cache_key
  end

  def write_user2cache(username, value)
    Rails.cache.write(username, value)
  end

  def online?(user)
    cache_key = user.respond_to?(:username) ? user.username : user
    !Rails.cache.read(cache_key).blank?
  end

  def current_user
    @current_user ||= begin
      User.find_by(username: session[:username])
    end
  end

end
