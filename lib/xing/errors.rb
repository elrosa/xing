module Xing
  module Errors
    class XingError < StandardError
      attr_reader :data
      def initialize(data)
        @data = data
        super
      end
    end

    class UnauthorizedError      < XingError; end
    class GeneralError           < XingError; end

    class UnavailableError       < StandardError; end
    class ServerError            < StandardError; end
    class NotFoundError          < StandardError; end
  end
end
