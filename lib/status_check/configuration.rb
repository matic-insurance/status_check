module StatusCheck
  class Configuration
    attr_accessor :checks

    AVAILABLE_SERVICES = %I{postgresql redis}

    def initialize
      @checks = []
    end

    def check(service_name, connection:)
      validate_name(service_name)
      service = Services.setup(name: service_name, connection: connection)
      @checks << service if service.try[:success]
    end

    private

    def validate_name(name)
      unless AVAILABLE_SERVICES.include?(name.to_sym)
        raise Errors::NotValidParams, "Name is not valid. It has to be one of this: #{AVAILABLE_SERVICES.join(', ')}"
      end
    end

  end
end
