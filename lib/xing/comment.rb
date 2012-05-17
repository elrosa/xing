module Xing
  class Comment < Xing::Base
    lazy_attr_reader :id, :content, :posted_at, :user

    # @return Time
    def posted_at
      @posted_at ||=  Time.parse(@attrs['created_at']).utc unless @attrs['created_at'].nil?
    end

    # @return Xing::User
    def user
      @user ||= Xing::User.new(@attrs.dup['creator']) unless @attrs["creator"].nil?
    end

  end
end