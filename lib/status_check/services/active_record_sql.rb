module StatusCheck
  module Services
    class ActiveRecordSql < BaseService
      def command
        connection.call.execute("SELECT 1;")
        true
      end
    end
  end
end
