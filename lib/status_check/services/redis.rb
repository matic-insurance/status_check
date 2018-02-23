module StatusCheck
  module Services
    class Redis < BaseService
      def command
        connection.call.get("1")
      end

      def name
        :redis
      end
    end
  end
end
