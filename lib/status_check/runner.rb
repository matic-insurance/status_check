module StatusCheck
  class Runner
    attr_reader :checks

    def initialize(checks)
      @checks = checks
    end

    def verify
      services_status = collect_services_status
      report_status(services_status)
    end

    private
    def report_status(services_status)
      overall = services_status.all? { |service| service[:success] }
      [overall, services_status]
    end

    def collect_services_status
      checks.each_pair.map do |name, service|
        verify_service(name, service)
      end
    end

    def verify_service(name, service)
      success, status = service.report_status
      {service: name, success: success, status: status}
    rescue => ex
      {service: name, success: false, status: ex.to_s}
    end
  end
end