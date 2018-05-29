require_relative 'abstract'

module StatusCheck
  module Services
    class BlockResult < Abstract
      def command
        !!connection.call
      end
    end
  end
end
