module Xing
  class CompanyProfile < Xing::Base
    lazy_attr_reader :id, :name, :photo, :url

    # @return Time
    def posted_at
      @posted_at ||=  Time.parse(@attrs['created_at']).utc unless @attrs['created_at'].nil?
    end

    # @return String
    def url
      @url ||= @attrs["permalink"] unless @attrs["permalink"].nil?
    end

    # @param other [Xing::Event]
    # @return [Boolean]
    def ==(other)
      super || (other.class == self.class && other.id == self.id)
    end
  end
end