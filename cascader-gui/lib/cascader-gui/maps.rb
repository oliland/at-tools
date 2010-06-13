require 'gtk2'

def get_details(cascader)
	cascader_re = /^\[([^\]]*)\]\[([^\]]*)\]\[([^\]]*)\]$/
	name = cascader_re.match(cascader)[1]
	host = cascader_re.match(cascader)[2]
	topics = cascader_re.match(cascader)[3].split(':').map { |topic| topic.capitalize }
	
	return [name,host,topics]
end

def at5n_map(hostname,cascaders)
	cascwindow = Gtk::Window.new("5.04, North Lab")
	cascwindow.set_default_size(800,600)
	
	cascmap = Gtk::Table.new(20,5,true)
	
##### 	MACHINE SECTION
	beriotbtn = Gtk::Label.new("beriot")
	cascmap.attach(beriotbtn, 1,2, 0,1 )
	nokelainenbtn = Gtk::Label.new("nokelainen")
	cascmap.attach(nokelainenbtn, 2,3,0,1)
	lovecchiobtn = Gtk::Label.new("lovecchio")
	cascmap.attach(lovecchiobtn,4,5,0,1)
	
	keslerbtn = Gtk::Label.new("kesler")
	cascmap.attach(keslerbtn,0,1,2,3)
	drurybtn = Gtk::Label.new("drury")
	cascmap.attach(drurybtn,0,1,3,4)
	tealbtn = Gtk::Label.new("teal")
	cascmap.attach(tealbtn,0,1,4,5)
	edlerbtn = Gtk::Label.new("edler")
	cascmap.attach(edlerbtn,0,1,5,6)
	krajicekbtn = Gtk::Label.new("krajicek")
	cascmap.attach(krajicekbtn,0,1,6,7)
	demitrabtn = Gtk::Label.new("demitra")
	cascmap.attach(demitrabtn,0,1,7,8)
	
	kobasewbtn = Gtk::Label.new("kobasew")
	cascmap.attach(kobasewbtn,4,5,2,3)
	karsumsbtn = Gtk::Label.new("karsums")
	cascmap.attach(karsumsbtn,4,5,3,4)
	marchandbtn = Gtk::Label.new("marchand")
	cascmap.attach(marchandbtn,4,5,5,6)
	auerbtn = Gtk::Label.new("auer")
	cascmap.attach(auerbtn,2,3,6,7)
	marquardtbtn = Gtk::Label.new("marquadt")
	cascmap.attach(marquardtbtn,3,4,6,7)
	cowanbtn = Gtk::Label.new("cowan")
	cascmap.attach(cowanbtn,2,3,7,8)
	goodwinbtn = Gtk::Label.new("goodwin")
	cascmap.attach(goodwinbtn,3,4,7,8)
	drakebtn = Gtk::Label.new("drake")
	cascmap.attach(drakebtn,4,5,8,9)
	charabtn = Gtk::Label.new("chara")
	cascmap.attach(charabtn,4,5,9,10)
	
	doorbtn = Gtk::Label.new("THE DOOR")
	cascmap.attach(doorbtn,0,1,10,11)
	
	danclabtn = Gtk::Label.new("dancla")
	cascmap.attach(danclabtn,4,5,10,11)
	baumgartnerbtn = Gtk::Label.new("baumgartner")
	cascmap.attach(baumgartnerbtn,4,5,11,12)
	
	allardbtn = Gtk::Label.new("allard")
	cascmap.attach(allardbtn,0,1,12,13)
	canungrabtn = Gtk::Label.new("canungra")
	cascmap.attach(canungrabtn,0,1,13,14)
	hordichukbtn = Gtk::Label.new("hordichuk")
	cascmap.attach(hordichukbtn,0,1,14,15)
	ferencebtn = Gtk::Label.new("ference")
	cascmap.attach(ferencebtn,0,1,15,16)
	rollobtn = Gtk::Label.new("rollo")
	cascmap.attach(rollobtn,0,1,16,17)
	iggybtn = Gtk::Label.new("iggy")
	cascmap.attach(iggybtn,0,1,17,18)
	
	bleskabtn = Gtk::Label.new("bleska")
	cascmap.attach(bleskabtn,2,3,12,13)
	stradebrokebtn = Gtk::Label.new("stradebroke")
	cascmap.attach(stradebrokebtn,3,4,12,13)
	daxterbtn = Gtk::Label.new("daxter")
	cascmap.attach(daxterbtn,2,3,13,14)
	jakbtn = Gtk::Label.new("jak")
	cascmap.attach(jakbtn,3,4,13,14)
	bouillionbtn = Gtk::Label.new("bouillion")
	cascmap.attach(bouillionbtn,4,5,14,15)
	salobtn = Gtk::Label.new("salo")
	cascmap.attach(salobtn,4,5,15,16)
	luongobtn = Gtk::Label.new("luongo")
	cascmap.attach(luongobtn,4,5,16,17)
	egenerbtn = Gtk::Label.new("egener")
	cascmap.attach(egenerbtn,4,5,17,18)
	
	bazzinibtn = Gtk::Label.new("bazzini")
	cascmap.attach(bazzinibtn,0,1,19,20)
	stobbartbtn = Gtk::Label.new("stobbart")
	cascmap.attach(stobbartbtn,1,2,19,20)
	burrowsbtn = Gtk::Label.new("burrows")
	cascmap.attach(burrowsbtn,2,3,19,20)
	widemanbtn = Gtk::Label.new("wideman")
	cascmap.attach(widemanbtn,3,4,19,20)
		
#####	END MACHINE SECTION

	exitbtn = Gtk::Button.new("Close")
   	exitbtn.signal_connect("clicked") {
   		cascwindow.destroy
   	}
   	
   	cascwindow.border_width = 10
   	cascwindow.add(cascmap)
   		
	cascmap.attach(exitbtn, 2,3,10,11)
	cascwindow.show_all
end

def at5s_map(hostname,cascaders)

	cascwindow = Gtk::Window.new("5.03, South Lab")
	cascwindow.set_default_size(800,600)
	
	cascmap = Gtk::Table.new(17,5,true)
	
	######## MACHINES
	
	dunsboroughbtn = Gtk::Label.new("dunsborough")
	yallingupbtn = Gtk::Label.new("yallingup")
	rockinghambtn = Gtk::Label.new("rockingham")
	nannupbtn = Gtk::Label.new("nannup")
	cascmap.attach(dunsboroughbtn,0,1,0,1)
	cascmap.attach(yallingupbtn,1,2,0,1)
	cascmap.attach(rockinghambtn,2,3,0,1)
	cascmap.attach(nannupbtn,3,4,0,1)
	
	yellebtn = Gtk::Label.new("yelle")
	harveybtn = Gtk::Label.new("harvey")
	busseltonbtn = Gtk::Label.new("busselton")
	cascmap.attach(yellebtn,0,1,2,3)
	cascmap.attach(harveybtn,0,1,3,4)
	cascmap.attach(busseltonbtn,0,1,4,5)
	
	savardbtn = Gtk::Label.new("savard")
	sturmbtn = Gtk::Label.new("sturm")
	schaeferbtn = Gtk::Label.new("schaefer")
	sobotkabtn = Gtk::Label.new("sobotka")
	cascmap.attach(savardbtn,4,5,2,3)
	cascmap.attach(sturmbtn,4,5,3,4)
	cascmap.attach(schaeferbtn,4,5,4,5)
	cascmap.attach(sobotkabtn,4,5,5,6)
	
	bodnarchukbtn = Gtk::Label.new("bodnarchuk")
	thombtn = Gtk::Label.new("thom")
	columnbtn = Gtk::Label.new("COLUMN")
	cascmap.attach(bodnarchukbtn,2,3,7,8)
	cascmap.attach(thombtn,2,3,10,11)
	cascmap.attach(columnbtn,2,3,8,10)
	
	doorbtn = Gtk::Label.new("DOOR")
	cascmap.attach(doorbtn,4,5,8,10)
	
	mandurahbtn = Gtk::Label.new("mandura")
	bunburybtn = Gtk::Label.new("bunbury")
	vassebtn = Gtk::Label.new("vasse")
	cascmap.attach(mandurahbtn,0,1,12,13)
	cascmap.attach(bunburybtn,0,1,13,14)
	cascmap.attach(vassebtn,0,1,14,15)
	
	leeuwinbtn = Gtk::Label.new("leeuwin")
	subiacobtn = Gtk::Label.new("subiaco")
	augustabtn = Gtk::Label.new("augusta")
	albanybtn = Gtk::Label.new("albany")
	cascmap.attach(leeuwinbtn,4,5,11,12)
	cascmap.attach(subiacobtn,4,5,12,13)
	cascmap.attach(augustabtn,4,5,13,14)
	cascmap.attach(albanybtn,4,5,14,15)
	
	wallcliffebtn = Gtk::Label.new("wallcliffe")
	ghautsbtn = Gtk::Label.new("ghauts")
	pembertonbtn = Gtk::Label.new("pemberton")
	esperancebtn = Gtk::Label.new("esperance")
	cascmap.attach(wallcliffebtn,0,1,16,17)
	cascmap.attach(ghautsbtn,1,2,16,17)
	cascmap.attach(pembertonbtn,2,3,16,17)
	cascmap.attach(esperancebtn,3,4,16,17)
	
	# me
	thordevbtn = Gtk::Label.new("thordev")
	cascmap.attach(thordevbtn,2,3,4,5)
	
	machinelist = [dunsboroughbtn, yallingupbtn, rockinghambtn, nannupbtn,
	yellebtn, savardbtn, harveybtn, sturmbtn, busseltonbtn, schaeferbtn,
	sobotkabtn, bodnarchukbtn, thombtn, leeuwinbtn, mandurahbtn, subiacobtn]
		
	######## END MACHINES

	exitbtn = Gtk::Button.new("Close")
   	exitbtn.signal_connect("clicked") {
   		cascwindow.destroy
   	}
   	
   	cascwindow.border_width = 10
   	cascwindow.add(cascmap)
	
	puts cascaders
	
	cascmap.children.each { |machine|
		if hostname == machine.text
			machine.text=(">>YOU ARE HERE<<")
		end
	}
	
	cascmap.attach(exitbtn,0,1,8,9)
	cascwindow.show_all
end
