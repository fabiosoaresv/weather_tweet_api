# frozen_string_literal: true

class Twitter::CreateTweet
  TWEET_URL = 'https://api.twitter.com/2/tweets'

  def public_weather(city)
    temperatures = get_temperatures(city)
    tweet_text = parse_temperatures(temperatures, city)
    sdk_client.execute_request(:post, TWEET_URL, tweet_text)
  end

  private

  def api_key
    @api_key ||= ENV['TWITTER_API_KEY']
  end

  def get_temperatures(city)
    weather_sdk.get_weather_by_city(city, api_key)
  end

  def parse_temperatures(temperatures, city)
    first_temperature = temperatures.first
    initial_data = "#{first_temperature.dig(:temperature).to_i}°C e #{first_temperature.dig(:weather)} em #{city} em #{first_temperature.dig(:date)}. Média para os próximos dias: "
    temperatures = temperatures[1..5].map { |data| "#{data.dig(:temperature).to_i}°C em #{data.dig(:date)}" }.join(', ')

    { text: "#{initial_data} #{temperatures}" }.to_json
  end

  def sdk_client
    @sdk_client ||= Twitter::Sdk.new
  end

  def weather_sdk
    @weather_sdk ||= WeatherSdk::Client
  end
end