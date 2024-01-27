class TwitterController < ApplicationController
  def create_tweet
    response = tweet_service.public_weather(city_params)

    render json: { message: 'Tweet created successfully!' } if response.dig('data', 'id')
  end

  private

  def tweet_service
    @tweet_service ||= Twitter::CreateTweet.new
  end

  def city_params
    params.require(:city)
  end
end