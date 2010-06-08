require 'thread'

class Client
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
        padding = " " * (35 - (host.length + lab.length))
        
        topics.map! do |topic|
            unless (/^\d$/ =~ topic).nil?
                pretty_years(topic.to_i).yellow
            else
                topic.yellow
            end
        end
        
        return "\t#{name.red}#{" " * (40 - name.length) }#{host.green} -- #{lab.blue}#{padding}#{topics.join '/'.white}"
    end
    
    def pretty_years(year)
        years = { 1 => "First Year",
                  2 => "Second Year",
                  3 => "Third Year",
                  4 => "Fourth Year" }
        
        return years[year]
    end
        
    
    def search
        puts 'Searching for cascaders...'
        
        lab_hosts = HostManager.get_hosts_lab(@user.floor, @user.lab)
        floor_hosts = HostManager.get_hosts_floor(@user.floor)
        lab_cascaders = []
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
        
        lab_cascaders.map! { |cascader| format_cascader(cascader) }
        puts "There are #{lab_cascaders.length} cascaders in this lab:"
        lab_cascaders.each { |cascader| puts cascader }
        
        floor_cascaders.map! { |cascader| format_cascader(cascader) }
        puts "There are #{floor_cascaders.length} other cascaders on this floor:"
        floor_cascaders.each { |cascader| puts cascader }
    end
end
