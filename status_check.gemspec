lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "status_check/version"

Gem::Specification.new do |spec|
  spec.name = "status_check"
  spec.version = StatusCheck::VERSION
  spec.authors = ["Vasyl Melnychuk", "Volodymyr Mykhailyk"]
  spec.email = ["vasyl.m@matic.com"]
  spec.licenses = ['MIT']

  spec.summary = %q{Status endpoint code to verify components availability of your application}
  spec.description = %q{
                          Gem allows easy implementation of a status endpoint in your project.
                          It provides boilerplate code for commonly used components (Database, Redis, etc)
                          and allow usage of your custom status check.

                          As a result, the gem can produce hash with a status of every component or be embedded into the routes
                          for an automatic status endpoint.
                       }
  spec.homepage = "https://github.com/matic-insurance/status_check"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
