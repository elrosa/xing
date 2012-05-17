module Xing
  class Post < Xing::Base
    lazy_attr_reader :action, :activities, :commentable, :comments, :deletable, :id,
                     :likable, :liked, :like_count, :posted_at, :sharable, :text, :type, :user

    # @return String
    def action
      fail "Not implemented"
    end

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
      @liked ||= @attrs["likes"]["current_user_liked"] unless @attrs["likes"].nil?
    end

    # @return Fixnum
    def like_count
      @like_count ||= @attrs["likes"]["amount"] unless @attrs["likes"].nil?
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