module StatusCheck
  module Services
    class Redis < Abstract
      def command
        connection.call.get("1")
        true
      end
    end
  end
end
