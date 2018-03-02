module StatusCheck
  module Services
    class Postgresql < BaseService
      def command
        connection.call.execute("SELECT 1;")
      end

      def name
        :postgresql
      end
    end
  end
end
