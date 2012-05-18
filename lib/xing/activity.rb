module Xing
  class Activity < Xing::Base
    lazy_attr_reader :name, :link, :object

    # @return String
    def name
      fail "Not implemented"
    end

    # @return String
    def link
      fail "Not implemented"
    end

    # @return
    def object
      fail "Not implemented"
    end

  end
end