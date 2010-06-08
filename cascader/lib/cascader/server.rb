require 'thread'

class Server
    def initialize(name, host, topics)
        @server = TCPServer.new(54415)
        @host = host
        @name = name
        @topics = topics.map { |topic| topic.gsub('[', '').gsub(']', '') }
        
        start
    end
    
    def start
        puts "Cascading...".blue
        response = "[#{@name}][#{@host}][#{@topics.join ':'}]"
        
        while (session = @server.accept)
            Thread.start(response) do |response|
                puts "Log: Cascader search from #{session.peeraddr[2].green} at #{session.peeraddr[3].green}"
                
                puts "Log: Sending Response"
                session.write "#{response}\n"
                
                puts "Log: Closing Connection"
                session.write "End Transmission\n"
            end
        end
    end
end