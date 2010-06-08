class UserGui
    attr_reader :hostname, :floor, :lab
    
    def initialize
        @username = ENV['USER']
        @hostname = `hostname`.chomp.split('.').first
#	@hostname = 'daxter'
        @floor = HostManager.lookup_floor(@hostname)
        @lab = HostManager.lookup_lab(@hostname)
    end
    
    def username
    	@username
    end
    def hostname
    	@hostname
    end
end
