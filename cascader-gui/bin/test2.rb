require 'socket'

host = 'localhost'
port = 54415
s = TCPSocket.open(host, port)
while line = s.gets
	puts line.chomp
end
s.close
