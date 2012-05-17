module Xing
  module Api
    module Reader

      def network_feed options={}
        path = "/users/" + user_id(options) + "/network_feed" + params(options).to_s
        raw_posts = get(path, options).fetch("network_activities", [])
        raw_posts.map{|post|
          Xing::Post.new(post)
        }
      end

      protected
        DEFAULT_PARAMS = {
            :user_fields => "id,display_name,permalink,photo_urls",
            :aggregate => false
        }

        def user_id options
          user_id = options.delete(:user_id) if options[:user_id]
          user_id || "me"
        end

        def params options
          params_str = ""
          params = options[:params] || {}
          params.merge!(DEFAULT_PARAMS)
          params.each { |key, value| params_str << "#{key}=#{value}&"}
          ("?" + params_str.chop) unless (params_str == "")
        end

    end
  end
end