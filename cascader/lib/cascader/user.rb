class User
    attr_reader :hostname, :floor, :lab
    
    def initialize
        @username = ENV['USER']
        @hostname = `hostname`.chomp.split('.').first
        @floor = HostManager.lookup_floor(@hostname)
        @lab = HostManager.lookup_lab(@hostname)
    end
end
