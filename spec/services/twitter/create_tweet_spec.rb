# spec/services/twitter/create_tweet_spec.rb

require 'rails_helper'

RSpec.describe Twitter::CreateTweet do
  describe '#public_weather' do
    let(:city) { 'Piraju' }
    let(:api_key) { 'some_api_key' }
    let(:sdk_double) { instance_double(Twitter::Sdk) }
    let(:weather_sdk_double) { class_double(WeatherSdk::Client) }
    let(:expected_tweet_text) { { "text" => '16°C e céu limpo em Piraju em 27/01. Média para os próximos dias:  19°C em 28/01, 19°C em 29/01, 25°C em 30/01, 26°C em 31/01, 19°C em 01/02' } }
    let(:mocked_weather_data) { [{:date=>"27/01", :temperature=>16.45, :weather=>"céu limpo"}, {:date=>"28/01", :temperature=>19.96, :weather=>"nuvens dispersas"}, {:date=>"29/01", :temperature=>19.73, :weather=>"chuva leve"}, {:date=>"30/01", :temperature=>25.11, :weather=>"nublado"}, {:date=>"31/01", :temperature=>26.05, :weather=>"nublado"}, {:date=>"01/02", :temperature=>19.29, :weather=>"chuva leve"}] }

    before do
      allow(weather_sdk_double).to receive(:get_weather_by_city).with(city, api_key).and_return(mocked_weather_data)
      allow(Twitter::Sdk).to receive(:new).and_return(sdk_double)
      allow(sdk_double).to receive(:execute_request).and_return({ 'data' => { 'id' => '123' } })
    end

    it 'should send a tweet with weather information' do
      create_tweet = Twitter::CreateTweet.new

      expected_json_text = expected_tweet_text.to_json

      expect(sdk_double).to receive(:execute_request).with(:post, Twitter::CreateTweet::TWEET_URL, expected_json_text).once
      expect(create_tweet.public_weather(city)).to eq({ "data" => { "id" => "123" } })
    end
  end
end
