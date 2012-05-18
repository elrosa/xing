module Xing
  class Post < Xing::Base
    lazy_attr_reader :commentable, :comments, :deletable, :id, :image,
                     :likable, :liked, :like_count, :link, :link_title,
                     :post_type, :posted_at, :sharable, :text, :type, :user


    # @return [Xing::Post]
    def initialize(attrs={})
      super
      self.activities
    end

    # @return [Xing::Activity]
    def activities
      @activities ||= @attrs["objects"].map{|activity| Xing::Activity.new(activity)} unless @attrs["objects"].nil?
    end

    # @return [Boolean]
    def commentable
      @commentable ||= @attrs["possible_actions"].nil? ? false : @attrs["possible_actions"].include?("COMMENT")
    end

    # @return [Xing::Comments]
    def comments
      @comments ||= @attrs["comments"].nil? ? [] : @attrs["comments"]["latest_comments"].map{|comment| Xing::Comment.new(comment)}
    end

    # @return [Boolean]
    def deletable
      @deletable ||= @attrs["possible_actions"].nil? ? false : @attrs["possible_actions"].include?("DELETE")
    end

    # @return String
    def image
      if @activities.first && @activities.first.type == "bookmark"
        @image ||= @activities.first.image
      end
    end

    # @return [Boolean]
    def likable
      @likable ||= @attrs["possible_actions"].nil? ? false : @attrs["possible_actions"].include?("LIKE")
    end

    # @return [Boolean]
    def liked
      @liked ||= @attrs["likes"]["current_user_liked"] unless @attrs["likes"].nil?
    end

    # @return Fixnum
    def like_count
      @like_count ||= @attrs["likes"]["amount"] unless @attrs["likes"].nil?
    end

    # @return String
    def link
      if @activities.first && @activities.first.type == "bookmark"
        @link ||= @activities.first.url
      end
    end

    # @return String
    def link_title
      if @activities.first && @activities.first.type == "bookmark"
        @link_title ||= @activities.first.title
      end
    end

    # @return Symbol
    def post_type
      if @activities.first && @activities.first.text
        @post_type ||= :text
      elsif @activities.first && self.user == @activities.first.object
        @post_type ||= :profile_update
      else
        @post_type ||= @attrs["verb"].gsub("-","_").to_sym
      end
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
      if @activities.first.text
        @text ||= @activities.first.text
      elsif @attrs["changes"]
        @text ||= (@attrs["verb"] + "_" + @attrs["changes"].first.downcase).gsub("-","_")
      else
        @text ||= (@attrs["verb"] + "_" + @activities.first.type).gsub("-","_")
      end
    rescue
      @text ||= ""
    end

    # @return Xing::User
    def user
      @user ||= Xing::User.new(@attrs.dup['actors'].first) unless @attrs["actors"].nil?
    end

  end
end