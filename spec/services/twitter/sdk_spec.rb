require 'rails_helper'

RSpec.describe Twitter::Sdk do
  describe '#execute_request' do
    it 'should send a POST request and parse the response' do
      sdk = Twitter::Sdk.new

      url = 'https://example.com/api'
      body = { key: 'value' }

      allow(HTTParty).to receive(:post).with(url, headers: anything, body: body).and_return(double(body: '{"result": "success"}'))

      response = sdk.execute_request(:post, url, body)

      expect(response).to eq('result' => 'success')
    end
  end
end
