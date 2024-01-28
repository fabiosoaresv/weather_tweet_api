# spec/controllers/twitter_controller_spec.rb
require 'rails_helper'

RSpec.describe TwitterController, type: :controller do
  describe 'POST #create_tweet successfully' do
    let(:tweet_service) { instance_double('Twitter::CreateTweet') }
    let(:weather_information_service) { instance_double('Twitter::UseCases::WeatherInformation') }
    let(:city_id) { '3453610' }

    before do
      allow(controller).to receive(:tweet_service).and_return(tweet_service)
      allow(controller).to receive(:weather_information_service).and_return(weather_information_service)
    end

    context 'when tweet is successfully created' do
      let(:response_data) { { 'data' => { 'id' => '123' } } }

      before do
        allow(weather_information_service).to receive(:execute).with(city_id).and_return('formatted_message')
        allow(tweet_service).to receive(:publish).with('formatted_message').and_return(response_data)
        post :create_tweet, params: { city_id: city_id }, format: :json
      end

      it 'returns a success message' do
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'Tweet created successfully!' })
      end
    end
  end

  describe 'POST #create_tweet failure' do
    let(:weather_sdk_double) { instance_double(WeatherSdk::Client) }
    let(:city_id) { '123' }

    context 'when tweet creation fails' do
      before do
        allow(weather_sdk_double).to receive(:get_weather_by_city_id).with(city_id, 'api_key').and_raise(WeatherSdk::Error, 'Cannot find city or execute request')
        post :create_tweet, params: { city_id: city_id }, format: :json
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Cannot create tweet, error: Cannot find city or execute request' })
      end
    end
  end
end
