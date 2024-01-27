module Twitter
  class Sdk
    def initialize
      set_variables
    end

    def execute_request(verb, url, body = {})
      response = case verb
                 when :post
                    HTTParty.post(url, headers: headers, body: body)
                 end

      JSON.parse(response.body)
    end

    private

    def set_variables
      oauth_signature = authenticator.generate_oauth_signature
      @oauth_consumer_key = oauth_signature['oauth_consumer_key']
      @oauth_nonce = oauth_signature['oauth_nonce']
      @oauth_token = oauth_signature['oauth_token']
      @oauth_timestamp = oauth_signature['oauth_timestamp']
      @oauth_signature = oauth_signature['oauth_signature']
    end

    def authenticator
      @authenticator ||= Twitter::Authenticator.new
    end

    def headers
      @headers ||= {
        'Content-Type' => 'application/json',
        'Authorization' => "OAuth oauth_consumer_key=\"#{@oauth_consumer_key}\",oauth_token=\"#{@oauth_token}\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\"#{@oauth_timestamp}\",oauth_nonce=\"#{@oauth_nonce}\",oauth_version=\"1.0\",oauth_signature=\"#{@oauth_signature}\""
      }
    end
  end
end