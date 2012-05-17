require 'oauth'

module Xing
  class << self
    attr_accessor :token, :secret

    def configure
      yield self
      true
    end
  end

  autoload :Api,      "xing/api"
  autoload :Client,   "xing/client"
  autoload :Mash,     "xing/mash"
  autoload :Errors,   "xing/errors"
  autoload :Helpers,  "xing/helpers"
  autoload :Base,     "xing/base"
  autoload :Post,     "xing/post"
  autoload :User,     "xing/user"
end
