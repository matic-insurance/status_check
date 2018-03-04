# StatusCheck

[![Build Status](https://travis-ci.org/matic-insurance/status_check.svg?branch=master)](https://travis-ci.org/matic-insurance/status_check)

Gem allows easy implementation of a status endpoint in your project. 
It provides boilerplate code for commonly used components (Database, Redis, etc) 
and allow usage of your custom status check. 

As a result, the gem can produce hash with a status of every component or be embedded into the routes 
for an automatic status endpoint. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'status_check'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install status_check

## Quick Usage

To use `status_check` you have to do 2 things:

First - create initializer, where you can define what services you want to be checked.
Example:
```ruby
StatusCheck.configure do |c|
  c.check(:my_service, service: StatusCheck::Services::BlockResult, connection: ->{ MyService.is_working? })
  c.check(:database, service: StatusCheck::Services::ActiveRecordSql, connection: ->{ ActiveRecord::Base.connection })
  c.check(:redis, service: StatusCheck::Services::ActiveRecordSql, connection: ->{ Redis.new(url: ENV['REDIS_URL']) })
end
```

Second - define the route in your `routes.rb` file
```ruby
Rails.application.routes.draw do
  ...

  match 'stats', to: StatusCheck::Router, via: :get

  ...
end
```

## Custom usage

You can use status check without routing. In any place of application call:
```ruby
success, report = StatusCheck.verify
puts success # true
puts report # [{service: 'database', success: true, status: 'OK'}, {service: 'redis', success: true, status: 'OK'}] 
```

Status check return tuple where first value is boolean (is all services checks are worked) and array of 
(details for each service)

## Builtin checks

#### ActiveRecordSql

Check connection to sql database configured via ActiveRecord

**class:** `StatusCheck::Services::ActiveRecordSql`
**connection:** block that returns instance of activerecord db connection. `->{ ActiveRecord::Base.connection }`
**verification:** verifies if applicaiton can read from database by executing `SELECT 1;`.    

#### Redis

Checks connection to redis

**class:** `StatusCheck::Services::Redis`
**connection:** block that returns instance of redis. `->{ Redis.new(url: 'redis://redis.com') }`
**verification:** verifies if application can read from redis by executing `GET 1`.     

#### BlockResult

Checks if connection block returns true or false

**class:** `StatusCheck::Services::BlockResult`
**connection:** block that returns true or false depending on status. `->{ MyService.is_working? }`
**verification:** verifies if block returns true or false.   

## Custom checks

There are two ways how you can implement your custom verifications. 

- Implement custom service see `StatusCheck::Services::Abstract`
- Use BlockResult service and implement verification inside of connection block

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/matic-insurance/status_check. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the StatusCheck project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/matic-insurance/status_check/blob/master/CODE_OF_CONDUCT.md).

## License

[MIT](LICENSE) 
 
## Author Information

Made with love in Matic
