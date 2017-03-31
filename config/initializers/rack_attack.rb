unless Rails.env.test?
  class Rack::Attack
    # Always allow requests from localhost
    # (blocklist & throttles are skipped)
    # self.safelist('allow from localhost') do |req|
    #   # Requests are allowed if the return value is truthy
    #   '127.0.0.1' == req.ip || '::1' == req.ip
    # end

    # Throttle all requests by IP (60rpm)
    #
    # Key: "rack::attack:#{Time.now.to_i/:period}:req/ip:#{req.ip}"
    throttle('req/ip', limit: 300, period: 5.minutes) do |req|
      req.ip unless req.path.start_with?('/assets')
    end

    # Throttle POST requests to /login by IP address
    #
    # Key: "rack::attack:#{Time.now.to_i/:period}:logins/ip:#{req.ip}"
    throttle('logins/ip', limit: 5, period: 20.seconds) do |req|
      req.ip if req.path == '/login' && req.post?
    end

    # Throttle POST requests to /login by username param
    #
    # Key: "rack::attack:#{Time.now.to_i/:period}:logins/username:#{req.username}"
    throttle('logins/username', limit: 5, period: 20.seconds) do |req|
      if req.path == '/login' && req.post?
        # return the email if present, nil otherwise
        req.params['username'].presence
      end
    end

    # Throttle POST requests to /messages by from_user param
    #
    # Key: "rack::attack:#{Time.now.to_i/:period}:messages/from_user:#{req.from_user}"
    throttle('messages/from_user', limit: 5, period: 20.seconds) do |req|
      if req.path == '/messages' && req.post?
        # return the email if present, nil otherwise
        req.params['from_user'].presence
      end
    end
  end
end
