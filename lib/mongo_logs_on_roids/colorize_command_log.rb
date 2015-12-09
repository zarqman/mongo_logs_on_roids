module MongoLogsOnRoids
  module ColorizeCommandLog

    CLEAR   = "\e[0m"
    BOLD    = "\e[1m"
    BLACK   = "\e[30m"
    RED     = "\e[31m"
    GREEN   = "\e[32m"
    YELLOW  = "\e[33m"
    BLUE    = "\e[34m"
    MAGENTA = "\e[35m"
    CYAN    = "\e[36m"
    WHITE   = "\e[37m"


    def started(event)
      if logger.debug?
        log_debug("#{prefix(event)} | #{MAGENTA}STARTED#{BLUE} | #{format_command(event.command)}")
      end
    end

    def succeeded(event)
      if logger.debug?
        log_debug("#{prefix(event)} | #{BOLD}#{GREEN}SUCCEEDED#{CLEAR}#{BLUE} | #{'%.3f' % (event.duration*1000)}ms")
      end
    end

    def failed(event)
      if logger.debug?
        log_debug("#{prefix(event)} | #{RED}FAILED#{BLUE} | #{YELLOW}#{event.message}#{BLUE} | #{'%.3f' % (event.duration*1000)}ms")
      end
    end


    private

    def format_command(args)
      message = super
      WHITE+message.gsub(/=>/){|m| MAGENTA+m+WHITE }+BLUE
    end

    PREFIX = Mongo::Loggable::PREFIX

    def format_message(message)
      format("#{BLUE}%s | %s#{CLEAR}".freeze, PREFIX, message)
    end

    def prefix(event)
      "#{event.address.to_s} | #{CYAN}#{event.database_name}#{BLUE}.#{YELLOW}#{event.command_name}#{BLUE}"
    end

  end
end
