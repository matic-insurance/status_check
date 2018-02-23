module StatusCheck
  module Services
    module_function

    SERVICES_MAP = {
      postgresql: Services::Postgresql,
      redis:      Services::Redis
    }
    
    def check_all
      StatusCheck
        .configuration
        .checks.map { |service| service.try }
    rescue
    end

    def setup(service)
      SERVICES_MAP[service[:name]].new(service[:connection])
    end
  end
end
