module Xing
  module Helpers
    module Authorization

      DEFAULT_OAUTH_OPTIONS = {
        :site => "https://api.xing.com",
        :request_token_path => "/v1/request_token",
        :authorize_path => "/v1/authorize",
        :access_token_path => "/v1/access_token"
      }

      # Note: If using oauth with a web app, be sure to provide :oauth_callback.
      # Options:
      #   :oauth_callback => String, url that LinkedIn should redirect to
      def request_token(options={})
        @request_token ||= consumer.get_request_token(options)
      end

      # For web apps use params[:oauth_verifier], for desktop apps,
      # use the verifier is the pin that LinkedIn gives users.
      def authorize_from_request(request_token, request_secret, verifier_or_pin)
        request_token = ::OAuth::RequestToken.new(consumer, request_token, request_secret)
        access_token  = request_token.get_access_token(:oauth_verifier => verifier_or_pin)
        @auth_token, @auth_secret = access_token.token, access_token.secret
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
