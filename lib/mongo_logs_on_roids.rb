require 'mongo'

require 'mongo_logs_on_roids/version'
require 'mongo_logs_on_roids/colorize_command_log'

Mongo::Monitoring::CommandLogSubscriber.prepend MongoLogsOnRoids::ColorizeCommandLog

if defined?(Rails)
  require 'mongo_logs_on_roids/runtime_subscriber'
  require 'mongo_logs_on_roids/railtie'
end
