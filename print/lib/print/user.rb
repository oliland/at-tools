class User
    attr_reader :print_manager
    
    def initialize
         @username = ENV['USER']
         @host = `hostname`.chomp.split('.').first
         @floor = HostManager.lookup_floor(@host)
         @print_manager = PrinterManager.new
         @log = File.expand_path('~/.at-tools/print.log')
    end
    
    def best_printer
        scores = @print_manager.scores(@floor).max.first
    end
    
    def write_job(printer, filename)
        File.open(@log, 'a+') do |log|
            log.puts Time.now.to_s + " " + printer + " " + filename
        end
    end
    
    def get_last_job
        log_re = /(\S+ \S+ \S+ \S+ \+\S+ \S+) (\S+) (.*)$/
        
        log = File.open(@log, 'r')
        last_job = log.readlines.last.chomp
        log.close
        
        date = log_re.match(last_job)[1]
        printer = log_re.match(last_job)[2]
        filename = log_re.match(last_job)[3]
        
        return printer, filename
    end
end
