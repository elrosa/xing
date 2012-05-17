module Xing
  class Post < Xing::Base
    lazy_attr_reader :activities, :commentable, :comments, :deletable, :id, :likable, :liked, :like_count,
                     :posted_at, :sharable, :text, :type, :user


    # @return [Xing::Activity]
    def activities
      fail "Not implemented"
    end

    def commentable
      @commentable ||= @attrs["possible_actions"].nil? ? false : @attrs["possible_actions"].include?("COMMENT")
    end

    # @return [Xing::Comments]
    def comments
      fail "Not implemented"
    end

    def deletable
      @deletable ||= @attrs["possible_actions"].nil? ? false : @attrs["possible_actions"].include?("DELETE")
    end

    def likable
      @likable ||= @attrs["possible_actions"].nil? ? false : @attrs["possible_actions"].include?("LIKE")
    end

    def liked
      fail "Not implemented"
    end

    # @return Fixnum
    def like_count
      fail "Not implemented"
    end

    # @return Time
    def posted_at
      @posted_at ||=  Time.parse(@attrs['created_at']).utc unless @attrs['created_at'].nil?
    end

    def sharable
      @commentable ||= @attrs["possible_actions"].include?("SHARE") unless @attrs["possible_actions"].nil?
    end

    # @return String
    def text
      fail "Not implemented"
    end

    # @return String
    def type
      fail "Not implemented"
    end

    # @return Xing::User
    def user
      @user ||= Xing::User.new(@attrs.dup['actors'].first) unless @attrs["actors"].nil?
    end

  end
end