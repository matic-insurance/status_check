module StatusCheck
  class Configuration
    attr_accessor :checks

    AVAILABLE_SERVICES = %I{postgresql redis}

    def initialize
      @checks = {}
    end

    def check(service_name, service:, connection:)
      service = setup_service(service, connection)
      validate_service(service)
      @checks[service_name] = service
    end

    private
    def setup_service(service_class, connection)
      service_class.new(connection)
    rescue => ex
      raise Errors::NotValidParams, "Service #{service_class} cannot be instantiated with connection: #{ex.message}"
    end

    def validate_service(service)
      unless service.respond_to?(:report_status)
        raise Errors::NotValidParams, "Service #{service.class} should respond to report_status"
      end
    end
  end
end
