require 'socket'
require 'pathname'
require 'gtk2'

class ServerGui
    def initialize(name, host, topics)
        @server = TCPServer.new(54415)
        @host = host
        @name = name
        @topics = topics.map { |topic| topic.gsub('[', '').gsub(']', '') }
        @status = false
        @looper = nil
        @logfile = File.open("#{APP_ROOT}/cascader_server_log", 'a')
    end
    
    def start(parent,parent2,icon)
        response = "[#{@name}][#{@host}][#{@topics.join ':'}]"

        dialog = Gtk::MessageDialog.new(
                $main_application_window,
                Gtk::Dialog::MODAL,
                Gtk::MessageDialog::INFO,
                Gtk::MessageDialog::BUTTONS_OK_CANCEL,
                message="Now cascading as #{@name} on #{@host}"
        )
        dialog.set_default_response(Gtk::Dialog::RESPONSE_OK)

        dialog.run do |reply|
        	case reply
        		when Gtk::Dialog::RESPONSE_OK
        			@status = true
        			parent.label = "Cascading..."
        			parent2.label = "Cascading..."
        			icon.pixbuf = Gdk::Pixbuf.new(LIB_ROOT + '/icons/cascading32.png')
        			@logfile.puts "-----\nStarted Cascading at #{Time.now.strftime("%d/%m/%y - %H:%M:%S")}"
		        	@looper = Thread.start {
		        		while (session = @server.accept)
						Thread.start(response) do |response|
			                		@logfile.puts "#{Time.now.strftime("%d/%m/%y - %H:%M:%S")} Log: Cascader search from #{session.peeraddr[2].green} at #{session.peeraddr[3].green}"
			
			                		@logfile.puts "#{Time.now.strftime("%d/%m/%y - %H:%M:%S")} Log: Sending Response"
			                		session.write "#{response}\n"
			
			                		@logfile.puts "#{Time.now.strftime("%d/%m/%y - %H:%M:%S")} Log: Closing Connection"
			                		session.write "End Transmission\n"
			            		end
			        	end	        				
	        		}
        	end
        	dialog.destroy
        end
    end
    
    def stop(parent,parent2, icon)
        dialog = Gtk::MessageDialog.new(
                $main_application_window,
                Gtk::Dialog::MODAL,
                Gtk::MessageDialog::INFO,
                Gtk::MessageDialog::BUTTONS_OK_CANCEL,
                message="Stop Cascading?"
        )
        dialog.run do |reply|
        	case reply
        		when Gtk::Dialog::RESPONSE_OK
        			parent.label = "Not Cascading."
        			parent2.label = "Not Cascading."
        			icon.pixbuf = Gdk::Pixbuf.new(LIB_ROOT + '/icons/cascade32.png')
        			@logfile.puts "Stopped Cascading at #{Time.now.strftime("%d/%m/%y - %H:%M:%S")}\n-----"
        			@status = false
        			@looper.exit
        	end
        	dialog.destroy
        end
    end
    
    def status
    	@status
    end
end
