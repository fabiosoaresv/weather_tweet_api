require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'rails/test_unit/railtie'
require 'dotenv'

Bundler.require(*Rails.groups)
Dotenv.load

module WeatherTweetApi
  class Application < Rails::Application
    config.load_defaults 7.1
    config.api_only = true
    config.autoload_paths += %W(#{config.root}/app/services)
  end
end
