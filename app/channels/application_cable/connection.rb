module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      Rails.cache.write(current_user.username, Time.zone.now) if current_user
    end

    private

    def find_verified_user
      current_user = User.find_by(username: cookies.signed[:username])
      if current_user
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
