require "status_check/version"
require "status_check/errors"
Dir[File.dirname(__FILE__) + '/status_check/services/*.rb'].each { |file| require file }
require "status_check/configuration"
require "status_check/router"
require "status_check/runner"
require 'json'

module StatusCheck
  class << self
    attr_accessor :configuration
  end

  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.verify
    Runner.new(configuration.checks).verify
  end
end
