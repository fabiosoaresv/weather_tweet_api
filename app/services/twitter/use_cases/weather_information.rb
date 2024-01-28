class Twitter::UseCases::WeatherInformation
  def execute(city_id)
    temperatures_data = get_temperatures(city_id)
    format_temperatures_message(temperatures_data[:temperatures], temperatures_data[:city_name])
  end

  private

  def get_temperatures(city_id)
    weather_sdk.get_weather_by_city_id(city_id, api_key)
  end

  def format_temperatures_message(temperatures, city_name)
    initial_data = parse_temperatures(temperatures.first, city_name)
    final_data = next_days_temperatures(temperatures)
    "#{initial_data}#{final_data}"
  end

  def parse_temperatures(temperature, city_name)
    "#{temperature.dig(:temperature).to_i}°C e #{temperature.dig(:weather)} em #{city_name} em #{temperature.dig(:date)}. Média para os próximos dias: "
  end

  def next_days_temperatures(temperatures)
    temperatures[1..5].map { |data| "#{data.dig(:temperature).to_i}°C em #{data.dig(:date)}" }.join(', ')
  end

  def api_key
    @api_key ||= ENV['API_KEY']
  end

  def weather_sdk
    @weather_sdk ||= WeatherSdk::Client.new(WeatherSdk::GetByCityService)
  end
end