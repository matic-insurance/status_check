require_relative 'base_service'

module StatusCheck
  module Services
    class BlockResult < BaseService
      def command
        !!connection.call
      end
    end
  end
end
