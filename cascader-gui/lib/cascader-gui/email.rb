require 'net/smtp'

def mailer(fromdetails, toaddress, subject, body)
	Net::SMTP.start('localhost', 25) do |smtp|
		msgstr = "From: #{fromdetails[0]} <#{fromdetails[1]}>
To: #{toaddress}
Subject: #{subject}
#{body}"				
		smtp.send_message msgstr,
			fromdetails[1],
			toaddress
	end 
end
