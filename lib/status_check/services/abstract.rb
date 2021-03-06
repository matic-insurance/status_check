module StatusCheck
  module Services
    class Abstract
      attr_reader :connection

      def initialize(connection)
        @connection = connection
      end

      def command
        raise NotImplementedError, "Check command have to be defined"
      end

      def status_message(command_result, exception = nil)
        return exception.to_s if !command_result && exception
        return 'FAILED' if !command_result
        'OK'
      end

      def report_status
        command_result = command
        status_hash(command_result)
      rescue StandardError => exception
        status_hash(command_result, exception)
      end

      private

      def status_hash(command_result, exception = nil)
        [!!command_result, status_message(command_result, exception)]
      end
    end
  end
end
