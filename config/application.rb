require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module WeatherTweetApi
  class Application < Rails::Application
    config.load_defaults 7.1
    config.autoload_lib(ignore: %w(assets tasks))
    config.api_only = true
    config.autoload_paths += %W(#{config.root}/app/services)
  end
end
