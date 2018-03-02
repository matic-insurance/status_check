module StatusCheck
  module Services
    module_function

    SERVICES_MAP = {
      postgresql: Services::Postgresql,
      redis: Services::Redis
    }

    def check_all
      StatusCheck
        .configuration
        .checks.map { |service| service.report_status }
    end

    def setup(service)
      SERVICES_MAP
        .fetch(service.fetch(:name))
        .new(service.fetch(:connection))
    rescue KeyError
      raise Errors::MissingParams, "You missed one of service params"
    end
  end
end
