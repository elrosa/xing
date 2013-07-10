module Xing
  module Api
    module Writer
      # @return [Hashie::Mash] with the return value from xing.
      # see https://dev.xing.com/docs/post/users/:user_id/conversations or create_conversation_result.json
      def create_conversation (*args)
        raise ArgumentError.new("subject must be a String") unless args[:subject].is_a?(String)
        raise ArgumentError.new("recipient_ids must be a non-empty Array") unless args[:recipient_ids].is_a?(Array) and not args[:recipient_ids].empty?
        raise ArgumentError.new("content must be a non-empty String") unless args[:content].is_a?(String) and not args[:content].empty?

        args[:recipient_ids] = args[:recipient_ids].join(",")

        path = '/users/me/conversations'

        args = args.to_a.map{|e| "#{e[0]}=#{e[1]}"}.join("&")

        Xing::Mash.new(post("#{path}?#{args}")['conversation'])
      end


      # @return [Hashie::Mash] with the response :code and :body from xing
      # see https://dev.xing.com/docs/post/users/:id/status_message
      def create_status_message(message)
        path = "/users/me/status_message?message=#{message}"
        Xing::Mash.new(post("#{path}"))
      end
    end
  end
end
