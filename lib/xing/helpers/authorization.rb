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


      #def parse_oauth_options
      #  {
      #    :request_token_url => full_oauth_url_for(:request_token, :api_host),
      #    :access_token_url  => full_oauth_url_for(:access_token,  :api_host),
      #    :authorize_url     => full_oauth_url_for(:authorize,     :auth_host),
      #    :site              => @consumer_options[:site] || @consumer_options[:api_host] || DEFAULT_OAUTH_OPTIONS[:api_host]
      #  }
      #end

        #  {
        #    :request_token_url => full_oauth_url_for(:request_token, :api_host),
        #    :access_token_url  => full_oauth_url_for(:access_token,  :api_host),
        #    :authorize_url     => full_oauth_url_for(:authorize,     :auth_host),
        #    :site              => @consumer_options[:site] || @consumer_options[:api_host] || DEFAULT_OAUTH_OPTIONS[:api_host]
        #  }
        #end
        #
        #def full_oauth_url_for(url_type, host_type)
        #  if @consumer_options["#{url_type}_url".to_sym]
        #    @consumer_options["#{url_type}_url".to_sym]
        #  else
        #    host = @consumer_options[:site] || @consumer_options[host_type] || DEFAULT_OAUTH_OPTIONS[host_type]
        #    path = @consumer_options[:"#{url_type}_path".to_sym] || DEFAULT_OAUTH_OPTIONS["#{url_type}_path".to_sym]
        #    "#{host}#{path}"
        #  end
        #end

    end

  end
end
