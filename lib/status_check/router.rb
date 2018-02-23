module StatusCheck
  module Router
    module_function

    def call(hash)
      response = Services.check_all
      status = response.map { |service| service[:success] }.all? ? 200 : 503
      [status, {}, [JSON.dump(response)]]
    end
  end
end
