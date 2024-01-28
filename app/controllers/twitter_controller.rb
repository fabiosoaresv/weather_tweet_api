class TwitterController < ApplicationController
  def create_tweet
    begin
      message = weather_information_service.execute(city_id)
      response = tweet_service.publish(message)

      render json: { message: 'Tweet created successfully!' } if response.dig('data', 'id')
    rescue WeatherSdk::Error => e
      render json: { error: "Cannot create tweet, error: #{e.message}" }, status: :unprocessable_entity
    end
  end

  private

  def tweet_service
    @tweet_service ||= Twitter::CreateTweet.new
  end

  def weather_information_service
    @weather_information_service ||= Twitter::UseCases::WeatherInformation.new
  end

  def city_id
    params.require(:city_id)
  end
end
