require 'active_support/log_subscriber'

module MongoLogsOnRoids
  class RuntimeSubscriber < ActiveSupport::LogSubscriber

    class << self
      def runtime=(value)
        Thread.current['mongo_runtime'] = value
      end

      def runtime
        Thread.current['mongo_runtime'] ||= 0
      end

      def reset_runtime
        rt, self.runtime = runtime, 0
        rt
      end
    end


    def started(event)
      # noop
    end
    def succeeded(event)
      self.class.runtime += event.duration*1000
    end
    def failed(event)
      self.class.runtime += event.duration*1000
    end
  end

  # Extends ActionController's logging system so as to include
  #   cumulative runtime at the end of each action's log entry.
  # See ActiveRecord::Railties::ControllerRuntime for reference
  module ControllerRuntime
    extend ActiveSupport::Concern

    protected

    attr_internal :runtime

    def process_action(action, *args)
      # We also need to reset the runtime before each action
      # because of queries in middleware or in cases we are streaming
      # and it won't be cleaned up by the method below.
      MongoLogsOnRoids::RuntimeSubscriber.reset_runtime
      super
    end

    def cleanup_view_runtime
      rt_before_render = MongoLogsOnRoids::RuntimeSubscriber.reset_runtime
      self.runtime = (runtime || 0) + rt_before_render
      runtime = super
      rt_after_render = MongoLogsOnRoids::RuntimeSubscriber.reset_runtime
      self.runtime += rt_after_render
      runtime - rt_after_render
    end

    def append_info_to_payload(payload)
      super
      payload[:mongo_runtime] = (runtime || 0) + MongoLogsOnRoids::RuntimeSubscriber.reset_runtime
    end


    module ClassMethods
      def log_process_action(payload)
        messages, rt = super, payload[:mongo_runtime]
        messages << ("Mongo: %.1fms" % rt.to_f) if rt && rt > 0
        messages
      end
    end

  end
end
