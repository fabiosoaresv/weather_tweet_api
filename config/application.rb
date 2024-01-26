require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module WeatherTweetApi
  class Application < Rails::Application
    config.load_defaults 7.1
    config.autoload_lib(ignore: %w(assets tasks))
    config.api_only = true
    config.autoload_paths += %W(#{config.root}/app/services)
  end
end
