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
    config.time_zone = 'Tokyo'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    config.generators do |g|
      g.test_framework :rspec,
                       fixtures:         true,
                       view_specs:       false,
                       routing_specs:    false,
                       controller_specs: true,
                       request_specs:    false,
                       helper_specs:     false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    config.middleware.use Rack::Attack unless Rails.env.test?

    config.action_cable.mount_path = '/chat'
  end
end
