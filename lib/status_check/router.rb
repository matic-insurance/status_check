module StatusCheck
  module Router
    module_function

    def call(hash)
      result, report = ::StatusCheck.verify
      status = result ? 200 : 503
      [status, {}, [JSON.dump(report)]]
    end
  end
end
