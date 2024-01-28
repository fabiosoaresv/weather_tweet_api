# frozen_string_literal: true

class Twitter::CreateTweet
  TWEET_URL = 'https://api.twitter.com/2/tweets'

  def publish(message)
    sdk_client.execute_request(:post, TWEET_URL, { text: message }.to_json)
  end

  private

  def sdk_client
    @sdk_client ||= Twitter::Sdk.new
  end
end