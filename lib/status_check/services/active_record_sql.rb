require_relative 'abstract'

module StatusCheck
  module Services
    class ActiveRecordSql < Abstract
      def command
        connection.call.execute("SELECT 1;")
        true
      end
    end
  end
end
