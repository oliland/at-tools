class HostManager
    level5_n = IO.readlines(File.dirname(__FILE__) + '/../../hosts/level5-n.txt').map {|host| host.chomp}
    level5_s = IO.readlines(File.dirname(__FILE__) + '/../../hosts/level5-s.txt').map {|host| host.chomp}
    level5_e = IO.readlines(File.dirname(__FILE__) + '/../../hosts/level5-e.txt').map {|host| host.chomp}
    level5_w = IO.readlines(File.dirname(__FILE__) + '/../../hosts/level5-w.txt').map {|host| host.chomp}
    
    
    @@hosts = { '5' => { 'at5n' => level5_n,
                         'at5s' => level5_s,
                         'at5e' => level5_e,
                         'at5w' => level5_w } }
    
    @@lab_names = { 'at5n' => 'Level 5 (North Lab)',
                    'at5s' => 'Level 5 (South Lab)',
                    'at5e' => 'Level 5 (East Labs)',
                    'at5w' => 'Level 5 (West Lab)' }
      
    def self.name_lab(lab)
        return @@lab_names[lab]
    end
    
    def self.lookup_lab(hostname)
        @@hosts.each_key do |floor|
            @@hosts[floor].each_pair do |lab, computers|
                return lab if computers.include? hostname
            end
        end
        puts "The computer you are using doesn't exist. Seek help."
        exit
    end
    
    def self.lookup_floor(hostname)
        @@hosts.each_key do |floor|
            @@hosts[floor].each_pair do |lab, computers|
                return floor if computers.include? hostname
            end
        end
        puts "The computer you are using doesn't exist. Seek help."
        exit
    end
    
    def self.get_hosts_floor(floor)
        hosts = []
        @@hosts[floor].each_value { |host| hosts << host}
        return hosts.flatten
    end
    
    def self.get_hosts_lab(floor, lab)
        return @@hosts[floor][lab]
    end
end
