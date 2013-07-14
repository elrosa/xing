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

      def network_feed2(options={},since_time)
        path = person_path(options) + "/network_feed"+"?since=#{since_time}" 
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

        options = {offset: 0, limit: 100}.merge(options)

        path = "/users/me/contacts" + hash_to_params(options)

        result = simple_query(path, options)['contacts']

        # if we didn't fetch all contacts, fetch next page
        new_offset = options[:offset] + options[:limit]
        if result['total'].to_i > new_offset
          result['users'] += contacts(options.merge(offset: new_offset))['users']
        end

        result
      end

      protected
        DEFAULT_PARAMS = {
            :user_fields => "id,display_name,permalink,photo_urls",
            :aggregate => false
        }

        def params options
          params = options[:params] || {}
          params.merge!(DEFAULT_PARAMS)
          hash_to_params params
        end

      def hash_to_params hash
        params_str = ""
        hash.each { |key, value|
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
