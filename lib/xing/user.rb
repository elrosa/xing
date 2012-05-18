module Xing
  class User < Xing::Base
    lazy_attr_reader :id, :name, :profile_image, :profile_url


    # @return String
    def name
      @name ||= @attrs["display_name"] unless @attrs["display_name"].nil?
    end

    # @return String
    def profile_image
      @profile_image ||= @attrs["photo_urls"]["medium_thumb"] unless (@attrs["photo_urls"].nil? || @attrs["photo_urls"]["medium_thumb"].nil?)
    end

    # @return String
    def url
      @profile_url ||= @attrs["permalink"] unless @attrs["permalink"].nil?
    end

    # @param other [Xing::User]
    # @return [Boolean]
    def ==(other)
      super || (other.class == self.class && other.id == self.id)
    end

  end
end