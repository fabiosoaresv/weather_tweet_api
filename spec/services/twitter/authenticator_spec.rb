require 'rails_helper'

RSpec.describe Twitter::Authenticator do
  describe '#generate_oauth_signature' do
    let(:authenticator) { Twitter::Authenticator.new }

    before do
      allow(OAuth::Consumer).to receive(:new).and_return(instance_double(OAuth::Consumer))
      allow(OAuth::Token).to receive(:new).and_return(instance_double(OAuth::Token))
      mocked_request = double('Net::HTTP::Post')
      allow(OAuth::Consumer).to receive(:new).and_return(instance_double(OAuth::Consumer, create_signed_request: mocked_request))
      allow(mocked_request).to receive(:[]=)
      allow(mocked_request).to receive(:body=)
      allow(mocked_request).to receive(:initialize_http_header)
      allow(mocked_request).to receive(:[]).with('Authorization').and_return('OAuth oauth_consumer_key="key", oauth_nonce="nonce", oauth_signature="signature", oauth_signature_method="HMAC-SHA1", oauth_timestamp="1706322544", oauth_token="token", oauth_version="1.0"')
    end

    it 'generates OAuth signature correctly' do
      expected_signature_keys = %w[oauth_consumer_key oauth_nonce oauth_signature oauth_timestamp oauth_token oauth_signature_method oauth_version]

      oauth_signature = authenticator.generate_oauth_signature
      expect(oauth_signature.keys).to contain_exactly(*expected_signature_keys)
    end
  end
end
