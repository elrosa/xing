require 'oauth'

module Xing
  class << self
    attr_accessor :token, :secret, :default_profile_fields

    def configure
      yield self
      true
    end
  end

  autoload :Activity,         "xing/activity"
  autoload :Api,              "xing/api"
  autoload :Base,             "xing/base"
  autoload :Client,           "xing/client"
  autoload :Comment,          "xing/comment"
  autoload :CommpanyProfile,  "xing/company_profile"
  autoload :Errors,           "xing/errors"
  autoload :Event,            "xing/event"
  autoload :Group,            "xing/group"
  autoload :Helpers,          "xing/helpers"
  autoload :Mash,             "xing/mash"
  autoload :Post,             "xing/post"
  autoload :User,             "xing/user"
end
