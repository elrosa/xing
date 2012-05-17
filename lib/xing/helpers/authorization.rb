module Xing
  module Helpers

    module Authorization

      DEFAULT_OAUTH_OPTIONS = {
        :site => "https://api.xing.com",
        :request_token_path => "/v1/request_token",
        :authorize_path => "/v1/authorize",
        :access_token_path => "/v1/access_token"
      }

      def consumer
        @consumer ||= ::OAuth::Consumer.new(@consumer_token, @consumer_secret, DEFAULT_OAUTH_OPTIONS)
      end

      def access_token
        @access_token ||= ::OAuth::AccessToken.new(consumer, @auth_token, @auth_secret)
      end

      def authorize_from_access(atoken, asecret)
        @auth_token, @auth_secret = atoken, asecret
      end

    end

  end
end
