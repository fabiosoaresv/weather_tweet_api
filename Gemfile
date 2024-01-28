source 'https://rubygems.org'

ruby '3.1.2'
gem 'rails', '~> 7.1.3'
gem 'puma', '>= 5.0'
gem 'tzinfo-data', platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]
gem 'bootsnap', require: false
gem 'weather_sdk', git: 'https://github.com/fabiosoaresv/weather_sdk.git', tag: 'v2.0.2'
gem 'httparty'
gem 'oauth'
gem 'dotenv-rails'

group :development, :test do
  gem 'debug', platforms: %i[ mri mswin mswin64 mingw x64_mingw ]
  gem 'byebug'
  gem 'rspec-rails'
end

group :development do
  gem 'error_highlight', '>= 0.4.0', platforms: [:ruby]
end

