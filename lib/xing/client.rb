module Xing

  class Client
    include Helpers::Authorization
    include Helpers::Request
    include Api::Reader
    include Api::Writer

    attr_reader :consumer_token, :consumer_secret, :consumer_options

    def initialize(ctoken=Xing.token, csecret=Xing.secret, options={})
      @consumer_token   = ctoken
      @consumer_secret  = csecret
      @consumer_options = options
    end

  end

end