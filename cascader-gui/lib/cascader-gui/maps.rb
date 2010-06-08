# require 'gtk2'


def level5_n_map
	level5_n = IO.readlines(File.dirname(__FILE__) + '/../../hosts/level5-n.txt').map {|host| host.chomp}

#	puts level5_n
#	level5_n.each {|pc| puts pc}
	
	cascwindow = Gtk::Window.new
	cascwindow.set_default_size(800,600)
	
	cascmap = Gtk::Table.new(10,10,true)
	
	left=0
	row=0
	count=0
	
	level5_n.each { |pc|
		if count<10 && row == 0
			pcbtn = Gtk::Label.new(pc)
			cascmap.attach(pcbtn, left, left+1, row, row+1)
			left +=1
			count += 1
		elsif count<10 && row>0 && row<8
			pcbtn = Gtk::Label.new(pc)
			cascmap.attach(pcbtn, left, left+1, row, row+1)
			left += 9
			count += 9
		elsif row==8
			pcbtn = Gtk::Label.new(pc)
			cascmap.attach(pcbtn, left, left+1, row, row+1)
			left += 1
			count += 1
		elsif row<9
			left = 0
			count = 0
			row += 1
		end
	}

   	exitbtn = Gtk::Button.new("Close")
   	exitbtn.signal_connect("clicked") {
   		cascwindow.destroy
   	}
   	
   	cascwindow.border_width = 10
   	cascwindow.add(cascmap)
	
	cascmap.attach(exitbtn, 4,6,9,10)
	cascwindow.show_all
end
