require 'socket'
require 'thread'

host = 'localhost'
port = 54415
output = ""

s = TCPSocket.new(host, port)

message = s.gets
puts message
output << message
if message.include?("End Transmission")
	clientSession.close
	puts output
end
