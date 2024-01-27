require 'rails_helper'

RSpec.describe TwitterController, type: :controller do
  describe 'POST #create_tweet' do
    let(:tweet_service) { instance_double('Twitter::CreateTweet') }
    let(:city) { 'Piraju' }

    before do
      allow(controller).to receive(:tweet_service).and_return(tweet_service)
    end

    context 'when tweet is successfully created' do
      let(:response_data) { { 'data' => { 'id' => '123' } } }

      before do
        allow(tweet_service).to receive(:public_weather).with(city).and_return(response_data)
        post :create_tweet, params: { city: city }, format: :json
      end

      it 'returns a success message' do
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'Tweet created successfully!' })
      end
    end

    context 'when tweet creation fails' do
      let(:response_data) { { 'data' => nil } }

      before do
        allow(tweet_service).to receive(:public_weather).with(city).and_return(response_data)
        post :create_tweet, params: { city: city }, format: :json
      end

      it 'returns an empty response' do
        expect(response).to have_http_status(:success)
        expect(response.body).to be_empty
      end
    end
  end
end

