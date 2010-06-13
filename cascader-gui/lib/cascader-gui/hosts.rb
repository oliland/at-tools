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
        # puts "The computer you are using appears not to exist, are you on DICE and on level5?"
        error = Gtk::MessageDialog.new($main_app_window,
        	Gtk::Dialog::MODAL,
        	Gtk::MessageDialog::INFO,
        	Gtk::MessageDialog::BUTTONS_CLOSE,
        	"The computer [%s] you are using appears not to exist.\nAre you on DICE and on level5?\nCascader-gui will now quit." % hostname)
        error.run
        error.destroy
        Gtk.main_quit
        exit
    end
    
    def self.lookup_floor(hostname)
        @@hosts.each_key do |floor|
            @@hosts[floor].each_pair do |lab, computers|
                return floor if computers.include? hostname
            end
        end
        # puts "The computer you are using appears not to exist, are you on DICE and on level5?"
        error = Gtk::MessageDialog.new($main_app_window,
        	Gtk::Dialog::MODAL,
        	Gtk::MessageDialog::INFO,
        	Gtk::MessageDialog::BUTTONS_CLOSE,
        	"The computer [%s] you are using appears not to exist.\nAre you on DICE and on level5?\nCascader-gui will now quit." % hostname)
        error.run
        error.destroy
        Gtk.main_quit
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
