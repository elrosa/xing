module Xing
  module Api
    module Reader

      def network_feed options={}
        path = person_path(options) + "/network_feed" + params(options).to_s        
        raw_posts = get(path, options).fetch("network_activities", [])
        raw_posts.map{|post|
          Xing::Post.new(post)
        }
      end

      def profile(options={})
        path = person_path(options)
        simple_query(path, options)
      end

      def contacts options={}
        path = person_path(options) + "/contacts"
        simple_query(path, options)
      end

      protected
        DEFAULT_PARAMS = {
            :user_fields => "id,display_name,permalink,photo_urls",
            :aggregate => false
        }

        def params options
          params_str = ""
          params = options[:params] || {}
          params.merge!(DEFAULT_PARAMS)
          params.each { |key, value| 
            puts "#{key}=#{value}"
            params_str << "#{key}=#{value}&"
          }
          ("?" + params_str.chop) unless (params_str == "")
        end

      private

        def simple_query(path, options={})
          headers = options.delete(:headers) || {}
          get(path, headers)
        end

        def person_path(options)
          path = "/users/"
          if id = options.delete(:id)
            path += "#{id}"
          else
            path += "me"
          end 
          if fields = options.delete(:fields)
            path += "?fields=#{fields}"
          end
          path
        end

    end
  end
end
