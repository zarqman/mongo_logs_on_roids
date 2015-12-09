module MongoLogsOnRoids
  class Railtie < Rails::Railtie

    ActiveSupport.on_load(:action_controller) do
      Mongo::Monitoring::Global.subscribe(Mongo::Monitoring::COMMAND, MongoLogsOnRoids::RuntimeSubscriber.new)
      include MongoLogsOnRoids::ControllerRuntime
    end

    console do |app|
      Mongo::Logger.logger = Logger.new($stdout)
      if defined?(Mongoid)
        config.mongoid.logger = Mongo::Logger.logger
      end
    end

  end
end
