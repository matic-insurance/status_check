# StatusCheck

This gem allows you to check your services with some custom route.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'status_check'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install status_check

## Usage

To use `status_check` you have to do 2 things:

First - create intializer, where you can define what services you want to be checked.
Example:
```ruby
StatusCheck.configure do |c|
  c.check(:postgresql, connection: ->{ ActiveRecord::Base.connection })
  c.check(:redis,      connection: ->{ Redis.new(url: ENV['REDIS_URL']) })
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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/status_check. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the StatusCheck project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/status_check/blob/master/CODE_OF_CONDUCT.md).

Made with love in Matic
