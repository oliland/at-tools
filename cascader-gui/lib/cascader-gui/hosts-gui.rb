def get_machine_info
    dialog = Gtk::Dialog.new("Machine Not Found!",
                             $main_application_window,
                             Gtk::Dialog::MODAL,
                             [ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_ACCEPT ],
                             [ Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_REJECT ])
    dialog.set_default_size(300,100)
    dialog.set_default_response(Gtk::Dialog::RESPONSE_ACCEPT)
    
    entry1 = Gtk::Entry.new
    entry1.max_length=50
    hostname = ENV['HOSTNAME']
    hostname ||= "Please enter details (once)."
    entry1.text = hostname
    entry1.select_region(0,-1)

    entry1lbl = Gtk::Label.new("Machine Name: ")
    entry2lbl = Gtk::Label.new("Lab: ")
    entry3lbl = Gtk::Label.new("Floor: ")
    
    entry2 = Gtk::Entry.new
    entry2.max_length=50
    entry2.set_activates_default(true)
    entry2.text = "Which lab are you in?"
    entry2.select_region(0,-1)
    
    entry3 = Gtk::Entry.new
    entry3.max_length=30
    entry3.set_activates_default(true)
    entry3.text = "Which floor are you on?"
    entry3.select_region(0,-1)


    tableholder = Gtk::Table.new(3,3,true)
    
    tableholder.attach(entry1lbl,0,1,0,1)
    tableholder.attach(entry1,1,3,0,1)
    tableholder.attach(entry2lbl,0,1,1,2)
    tableholder.attach(entry2,1,3,1,2)
    tableholder.attach(entry3lbl,0,1,2,3)
    tableholder.attach(entry3,1,3,2,3)

    dialog.vbox.add(tableholder)
    
    dialog.show_all
    
    dialog.run do |reply|
    	case reply
    		when Gtk::Dialog::RESPONSE_ACCEPT
		        mailer(["cascaders","cascaders@isthat.it"],
		        	"cascaders@isthat.it",
		        	"[cascader] new machine info - #{entry1.text}",
		        	"New Machine Found: #{entry1.text}, in #{entry2.text} on level #{entry3.text}.
Please add in to the program.")
    	end
    	dialog.destroy
    end
end

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
        # puts "The computer [%s] you are using appears not to exist, are you on DICE and on level5?" % hostname
        
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
        
        get_machine_info
        
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
