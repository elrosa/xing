require 'multi_json'
require 'uri'

module Xing
  module Helpers
    module Request

      API_PATH        = '/v1'
      DEFAULT_HEADERS = {}

      protected

      def escape path
        URI.escape path
      end


      def get(path, options={})
        response = access_token.get("#{API_PATH}#{escape path}", DEFAULT_HEADERS.merge(options))
        respond response
      end

      def post(path, body='', options={})
        response = access_token.post("#{API_PATH}#{escape path}", body, DEFAULT_HEADERS.merge(options))
        respond response
      end

      def put(path, body, options={})
        response = access_token.put("#{API_PATH}#{escape path}", body, DEFAULT_HEADERS.merge(options))
        respond response
      end

      def delete(path, options={})
        response = access_token.delete("#{API_PATH}#{escape path}", DEFAULT_HEADERS.merge(options))
        respond response
      end

      private

      def respond response
        raise_errors response
        begin
          MultiJson.load(response.body)
        rescue
          { code: response.code.to_i, body: response.body }
        end
      end

      def raise_errors(response)

        case response.code.to_i
          when 401
            data = Mash.from_json(response.body)
            raise Xing::Errors::UnauthorizedError.new(data), "(#{data.status}): #{data.message}"
          when 400, 403
            data = Mash.from_json(response.body)
            raise Xing::Errors::GeneralError.new(data), "(#{data.status}): #{data.message}"
          when 404
            raise Xing::Errors::NotFoundError, "(#{response.code}): #{response.message}"
          when 500
            raise Xing::Errors::ServerError, "(#{response.code}): #{response.message}"
          when 502..503
            raise Xing::Errors::UnavailableError, "(#{response.code}): #{response.message}"
        end
      end

      def to_query(options)
        options.inject([]) do |collection, opt|
          collection << "#{opt[0]}=#{opt[1]}"
          collection
        end * '&'
      end

      def to_uri(path, options)
        uri = URI.parse(path)

        if options && options != {}
          uri.query = to_query(options)
        end
        uri.to_s
      end

    end
  end
end
