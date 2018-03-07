# MongoLogsOnRoids

Better logging for mongodb on Ruby.

Compatible with just the `mongo` gem (v2.1+). Auto-detects Mongoid 5-7 and Rails and enables appropriate features.

Makes mongo logs more awesome with:

* Colorized logging
* Calculating and displaying total time in mongo (Rails):
  `Completed 200 OK in 13ms (Views: 0.2ms | Mongo: 3.2ms)`


## Installation

Install like any other gem. Add to your Gemfile:

```ruby
gem 'mongo_logs_on_roids'
```


## Usage

Under normal circumstances, should activate itself automatically.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zarqman/mongo_logs_on_roids.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Inspired by [mongoid_colored_logger](https://github.com/romanbsd/mongoid_colored_logger), by Roman Shterenzon (thanks!).
