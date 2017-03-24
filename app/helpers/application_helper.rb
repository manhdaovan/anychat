module ApplicationHelper
  def redirect_back_or(path)
    redirect_to session[:forward_url] || path
  end

  def store_user_info(user)
    cache_key   = user.respond_to?(:username) ? user.username : user
    cache_value = user.respond_to?(:username) ? user.id : user
    Rails.cache.write(cache_key, cache_value)
    session[:username]        = cache_key
    cookies.signed[:username] = cache_key
  end

  def online?(user)
    cache_key = user.respond_to?(:username) ? user.username : user
    !Rails.cache.read(cache_key).blank?
  end

end
