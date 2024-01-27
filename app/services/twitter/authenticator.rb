# frozen_string_literal: true

module Twitter
  class Authenticator
    TWITTER_URL = 'https://api.twitter.com'

    def initialize
      @consumer_key = ENV['CONSUMER_KEY']
      @consumer_secret = ENV['CONSUMER_SECRET']
      @access_token = ENV['ACCESS_TOKEN']
      @token_secret = ENV['TOKEN_SECRET']
    end

    def generate_oauth_signature
      consumer = OAuth::Consumer.new(@consumer_key, @consumer_secret, site: TWITTER_URL)
      token = OAuth::Token.new(@access_token, @token_secret)
      request = consumer.create_signed_request(:post, 'https://api.twitter.com/2/tweets', token, {}, {})

      parse_to_hash(request['Authorization'])
    end

    private

    def parse_to_hash(response)
      response = response.gsub(/^OAuth /, '').scan(/(\w+)="([^"]*)"/)
      Hash[response]
    end
  end
end