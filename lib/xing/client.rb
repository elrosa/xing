module Xing

  class Client
    include Helpers::Request
    include Api::Reader
    include Api::Writer

    attr_reader :consumer_token, :consumer_secret, :consumer_options

    def initialize(options={})
      @consumer_key     = options[:consumer_key]
      @consumer_secret  = options[:consumer_secret]
      @auth_token       = options[:oauth_token]
      @auth_secret      = options[:oauth_token_secret]
    end

    def consumer
      @consumer ||= ::OAuth::Consumer.new(@consumer_key, @consumer_secret, DEFAULT_OAUTH_OPTIONS)
    end

    def access_token
      @access_token ||= ::OAuth::AccessToken.new(consumer, @auth_token, @auth_secret)
    end

    protected
      DEFAULT_OAUTH_OPTIONS = {
        :site => "https://api.xing.com",
        :request_token_path => "/v1/request_token",
        :authorize_path => "/v1/authorize",
        :access_token_path => "/v1/access_token"
      }


  end

end