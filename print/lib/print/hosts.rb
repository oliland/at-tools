class HostManager
    level5 = IO.readlines(File.dirname(__FILE__) + '/hosts/level5.txt').map {|host| host.chomp}
    
    @@hosts = { 5 => level5 }
    
    def self.lookup_floor(hostname)
        @@hosts.each_pair do |floor, computers|
            return floor if computers.include? hostname
        end
        puts "The computer you are using doesn't exist. Seek help."
        exit
    end
end