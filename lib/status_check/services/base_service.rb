module StatusCheck
  module Services
    class BaseService
      def initialize(connection)
        @connection = connection
      end

      def try
        command
        response.merge(success: true)
      rescue StandardError => error
        response.merge(
          success: :false,
          error_message: error)
      end

      def name
        raise NotImplementedError, "Name have to be defined"
      end

      def command
        raise NotImplementedError, "Check command have to be defined"
      end

      private

      attr_reader :connection

      def response
        {service: name}
      end
    end
  end
end
