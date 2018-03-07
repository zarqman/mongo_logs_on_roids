module MongoLogsOnRoids
  class Railtie < Rails::Railtie

    ActiveSupport.on_load(:action_controller) do
      Mongo::Monitoring::Global.subscribe(Mongo::Monitoring::COMMAND, MongoLogsOnRoids::RuntimeSubscriber.new)
      include MongoLogsOnRoids::ControllerRuntime
    end

  end
end
