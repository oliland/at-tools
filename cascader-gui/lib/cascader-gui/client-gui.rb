require 'thread'
require 'gtk2'

class ClientGui
    def initialize(user)
        @user = user
        @cascaders = []
        @mutex = Mutex.new
    end
    
    def format_cascader(cascader)
        cascader_re = /^\[([^\]]*)\]\[([^\]]*)\]\[([^\]]*)\]$/
        name = cascader_re.match(cascader)[1]
        host = cascader_re.match(cascader)[2]
        topics = cascader_re.match(cascader)[3].split(':').map { |topic| topic.capitalize }

        lab = HostManager.name_lab(HostManager.lookup_lab(host))
        
        topics.map! do |topic|
            unless (/^\d$/ =~ topic).nil?
                pretty_years(topic.to_i)
            else
                topic
            end
        end
        
        return "\t#{name} @ #{host} -- #{lab} -- #{topics.join '/'}"
    end
    
    def pretty_years(year)
        years = { 1 => "First Year",
                  2 => "Second Year",
                  3 => "Third Year",
                  4 => "Fourth Year" }
        
        return years[year]
    end
            
    def search(parent)
        dialog = Gtk::MessageDialog.new(
        	parent,
        	Gtk::Dialog::MODAL,
	        Gtk::MessageDialog::INFO,
                Gtk::MessageDialog::BUTTONS_OK_CANCEL,
                message="Will now search for cascaders.\nPress OK to continue."
        )
        dialog.run do |reply|
        	case reply
        		when Gtk::Dialog::RESPONSE_OK
				search_labs(parent)
		end
		dialog.destroy
	end
    end
    
    def search_labs(parent)
        lab_hosts = HostManager.get_hosts_lab(@user.floor, @user.lab)
        floor_hosts = HostManager.get_hosts_floor(@user.floor)
        lab_cascaders = []
        lab_cascaders_map = []
        floor_cascaders = []
        
        lab_hosts.each do |hostname|
            Thread.start do
                begin
                    session = TCPSocket.new(hostname, 54415)
                rescue
                    next
                end

                server_message = session.gets
                lab_cascaders << server_message
  
                if server_message.include?("End Transmission")
                    clientSession.close
                end
            end
        end
        
        floor_hosts.each do |hostname|
            Thread.start do
                begin
                    session = TCPSocket.new(hostname, 54415)
                rescue
                    next
                end

                server_message = session.gets
                floor_cascaders << server_message
  
                if server_message.include?("End Transmission")
                    clientSession.close
                end
            end
        end
        
        (floor_cascaders & lab_cascaders).each { |dup| floor_cascaders.delete(dup) }
	
	lab_cascaders_map = lab_cascaders.slice(0..-1)
	
	unless lab_cascaders.length > 0        
	        lab_cascaders.map! { |cascader| format_cascader(cascader) }
		output = "There are #{lab_cascaders.length} cascaders in this lab:\n"
        	lab_cascaders.each { |cascader| output << cascader+"\n" }
        
        	floor_cascaders.map! { |cascader| format_cascader(cascader) }
        	output <<  "\nThere are #{floor_cascaders.length} other cascaders on this floor:\n"
        	floor_cascaders.each { |cascader| output << cascader+"\n" }
	        
	        dialog = Gtk::MessageDialog.new(
	       		parent,
	      		Gtk::Dialog::MODAL,
	        	Gtk::MessageDialog::INFO,
			Gtk::MessageDialog::BUTTONS_OK,
               	message=output
        	)
        	dialog.run
        	dialog.destroy
	end
        
        if lab_cascaders.length > 0
        	if @user.lab == "at5n"
	        	at5n_map(@user.hostname,lab_cascaders_map)
	        elsif @user.lab == "at5w"
        		at5w_map(@user.hostname,lab_cascaders_map)
        	elsif @user.lab == "at5s"
	        	at5s_map(@user.hostname,lab_cascaders_map)
	        elsif @user.lab == "at5e"
	        	at5e_map(@user.hostname,lab_cascaders_map)
	        end
	end
    end
end #class
