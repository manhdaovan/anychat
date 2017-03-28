require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Anychat
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    if Rails.env.development? || Rails.env.production?
      config.middleware.use Rack::Attack
    end

    config.action_cable.mount_path = '/chat'
    # config.action_cable.log_tags   = [
    #   :action_cable,
    #   -> request { request.cookies["user_id"].nil? ? "no-account" : 'loggedin-user' },
    #   -> request { request.uuid }
    # ]
  end
end
