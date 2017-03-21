class Rack::Attack
  # Always allow requests from localhost
  # (blocklist & throttles are skipped)
  # self.safelist('allow from localhost') do |req|
  #   # Requests are allowed if the return value is truthy
  #   '127.0.0.1' == req.ip || '::1' == req.ip
  # end

  throttle('req/ip', :limit => 300, :period => 5.minutes) do |req|
    req.ip unless req.path.start_with?('/assets')
  end

  throttle('logins/ip', :limit => 5, :period => 20.seconds) do |req|
    if req.path == '/login' && req.post?
      req.ip
    end
  end

  throttle("logins/username", :limit => 5, :period => 20.seconds) do |req|
    if req.path == '/login' && req.post?
      # return the email if present, nil otherwise
      req.params['username'].presence
    end
  end
end