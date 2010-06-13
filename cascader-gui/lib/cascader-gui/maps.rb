require 'gtk2'

def get_details(cascader)
	cascader_re = /^\[([^\]]*)\]\[([^\]]*)\]\[([^\]]*)\]$/
	name = cascader_re.match(cascader)[1]
	host = cascader_re.match(cascader)[2]
	topics = cascader_re.match(cascader)[3].split(':').map { |topic| topic.capitalize }
	
	return [name,host,topics]
end

def update_map(hostname,cascaders,cascmap)
	cascmap.children.each { |machine|
		if hostname == machine.text
			machine.text=(">>YOU ARE HERE<<")
			cascaders.each { |cascader|
				details = get_details(cascader)
				if details[1] == machine.text
					machine.text=("CASCADER:\n#{details[0]}\n[#{details[2]}]")
				end
			}
		end
		
	}
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

	update_map(hostname,cascaders,cascmap)
   	
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
	
	
	######## END MACHINES

	exitbtn = Gtk::Button.new("Close")
   	exitbtn.signal_connect("clicked") {
   		cascwindow.destroy
   	}
   	
   	cascwindow.border_width = 10
   	cascwindow.add(cascmap)
	
	update_map(hostname,cascaders,cascmap)
	
	cascmap.attach(exitbtn,0,1,8,9)
	cascwindow.show_all
end


def at5e_map(hostname,cascaders)

	cascwindow = Gtk::Window.new("5.01/2, East Labs")
	cascwindow.set_default_size(800,600)
	
	cascmap = Gtk::Table.new(9,12,true)
	######## MACHINES

	# me
#	thordevbtn = Gtk::Label.new("thordev")
#	cascmap.attach(thordevbtn,2,3,4,5)

	lift1btn = Gtk::Label.new("Lift")
	lift2btn = Gtk::Label.new("Lift")
	lift3btn = Gtk::Label.new("Lift")
	cascmap.attach(lift1btn,1,2,0,1)
	cascmap.attach(lift2btn,2,3,0,1)
	cascmap.attach(lift3btn,3,4,0,1)

	taybtn = Gtk::Label.new("tay")
	tarsanbtn = Gtk::Label.new("tarsan")
	strathbergbtn = Gtk::Label.new("strathberg")
	lessardbtn = Gtk::Label.new("lessard")
	cascmap.attach(taybtn,0,1,3,4)
	cascmap.attach(tarsanbtn,1,2,3,4)
	cascmap.attach(strathbergbtn,2,3,3,4)
	cascmap.attach(lessardbtn,3,4,3,4)
	
	door1btn = Gtk::Label.new("5.01 Door")
	cascmap.attach(door1btn,4,5,4,5)
	
	treigbtn = Gtk::Label.new("treig")
	getundebtn = Gtk::Label.new("getunde")
	dandenaultbtn = Gtk::Label.new("dandenault")
	cascmap.attach(treigbtn,0,1,5,6)
	cascmap.attach(getundebtn,1,2,5,6)
	cascmap.attach(dandenaultbtn,2,3,7,8)
	
	villeneuvebtn = Gtk::Label.new("villeneuve")
	fangiobtn = Gtk::Label.new("fangio")
	alonsobtn = Gtk::Label.new("alonso")
	surteesbtn = Gtk::Label.new("surtees")
	cascmap.attach(villeneuvebtn,8,9,1,2)
	cascmap.attach(fangiobtn,9,10,1,2)
	cascmap.attach(alonsobtn,10,11,1,2)
	cascmap.attach(surteesbtn,11,12,1,2)
	
	fittipaldibtn = Gtk::Label.new("fittipaldi")
	ascaribtn = Gtk::Label.new("ascari")
	laudabtn = Gtk::Label.new("lauda")
	prostbtn = Gtk::Label.new("prost")
	cascmap.attach(fittipaldibtn,8,9,3,4)
	cascmap.attach(ascaribtn,9,10,3,4)
	cascmap.attach(laudabtn,10,11,3,4)
	cascmap.attach(prostbtn,11,12,3,4)
	
	door2btn = Gtk::Label.new("5.03 Door")
	cascmap.attach(door2btn,7,8,4,5)
	
	itobtn = Gtk::Label.new("Door to the ITO")
	cascmap.attach(itobtn,6,7,6,7)
	
	######## END MACHINES

	exitbtn = Gtk::Button.new("Close")
   	exitbtn.signal_connect("clicked") {
   		cascwindow.destroy
   	}
   	
   	cascwindow.border_width = 10
   	cascwindow.add(cascmap)
	
	update_map(hostname,cascaders,cascmap)
	
	cascmap.attach(exitbtn,0,1,8,9)
	cascwindow.show_all
end

def at5w_map(hostname,cascaders)

	cascwindow = Gtk::Window.new("West Lab")
	cascwindow.set_default_size(800,600)
	
	cascmap = Gtk::Table.new(12,11,true)
	######## MACHINES

	# me
#	thordevbtn = Gtk::Label.new("thordev")
#	cascmap.attach(thordevbtn,2,3,4,5)
	
	#  btn = Gtk::Label.new("
	#  cascmap.attach(
	
	wallanderbtn = Gtk::Label.new("wallander")
	lemmingbtn = Gtk::Label.new("lemming")
	moosebtn = Gtk::Label.new("moose")
	mankellbtn = Gtk::Label.new("mankell")
	cascmap.attach(wallanderbtn,2,3,0,1)
	cascmap.attach(lemmingbtn,2,3,1,2)
	cascmap.attach(moosebtn,2,3,2,3)
	cascmap.attach(mankellbtn,2,3,3,4)
	
	cottontailbtn = Gtk::Label.new("cottontail")
	bobcatbtn = Gtk::Label.new("bobcat")
	raccoonbtn = Gtk::Label.new("raccoon")
	coyotebtn = Gtk::Label.new("coyote")
	cascmap.attach(cottontailbtn,3,4,0,1)
	cascmap.attach(bobcatbtn,3,4,1,2)
	cascmap.attach(raccoonbtn,3,4,2,3)
	cascmap.attach(coyotebtn,3,4,3,4)

	infdoorbtn = Gtk::Label.new("Door to InfBase")
	cascmap.attach(infdoorbtn,0,1,4,5)
	
	ohlundbtn = Gtk::Label.new("ohlund")
	samuelssonbtn = Gtk::Label.new("samuelsson")
	oduyabtn = Gtk::Label.new("oduya")
	plekanecbtn = Gtk::Label.new("plekanec")
	djurgardensbtn = Gtk::Label.new("djurgardens")
	cascmap.attach(ohlundbtn,0,1,5,6)
	cascmap.attach(samuelssonbtn,1,2,5,6)
	cascmap.attach(oduyabtn,2,3,5,6)
	cascmap.attach(plekanecbtn,3,4,5,6)
	cascmap.attach(djurgardensbtn,4,5,5,6)
	
	col1btn = Gtk::Label.new("COLUMN")
	bradfordbtn = Gtk::Label.new("bradford")
	kostitsynbtn = Gtk::Label.new("kostitsyn")
	kolvubtn = Gtk::Label.new("kolvu")
	chipchurabtn = Gtk::Label.new("chipchura")
	cascmap.attach(col1btn,0,1,6,7)
	cascmap.attach(bradfordbtn,1,2,6,7)
	cascmap.attach(kostitsynbtn,2,3,6,7)
	cascmap.attach(kolvubtn,3,4,6,7)
	cascmap.attach(chipchurabtn,4,5,6,7)
	
	willsiebtn = Gtk::Label.new("willsie")
	raycroftbtn = Gtk::Label.new("raycroft")
	guitebtn = Gtk::Label.new("guite")
	clarkbtn = Gtk::Label.new("clark")
	monotremebtn = Gtk::Label.new("monotreme")
	cascmap.attach(willsiebtn,0,1,7,8)
	cascmap.attach(raycroftbtn,1,2,7,8)
	cascmap.attach(guitebtn,2,3,7,8)
	cascmap.attach(clarkbtn,3,4,7,8)
	cascmap.attach(monotremebtn,4,5,7,8)
	
	davidsonbtn = Gtk::Label.new("davidson")
	coulthardbtn = Gtk::Label.new("coulthard")
	hillbtn = Gtk::Label.new("hill")
	brabhambtn = Gtk::Label.new("brabham")
	mansellbtn = Gtk::Label.new("mansell")
	cascmap.attach(davidsonbtn,0,1,8,9)
	cascmap.attach(coulthardbtn,1,2,8,9)
	cascmap.attach(hillbtn,2,3,8,9)
	cascmap.attach(brabhambtn,3,4,8,9)
	cascmap.attach(mansellbtn,4,5,8,9)
	
	col2btn = Gtk::Label.new("COLUMN")
	hamiltonbtn = Gtk::Label.new("hamilton")
	eishortbtn = Gtk::Label.new("eishort")
	huntbtn = Gtk::Label.new("hunt")
	assyntbtn = Gtk::Label.new("assynt")
	cascmap.attach(col2btn,0,1,9,10)
	cascmap.attach(hamiltonbtn,1,2,9,10)
	cascmap.attach(eishortbtn,2,3,9,10)
	cascmap.attach(huntbtn,3,4,9,10)
	cascmap.attach(assyntbtn,4,5,9,10)
	
	homstrombtn = Gtk::Label.new("homstrom")
	sennabtn = Gtk::Label.new("senna")
	samsonovbtn = Gtk::Label.new("samsonov")
	lidstormbtn = Gtk::Label.new("lidstorm")
	modinbtn = Gtk::Label.new("modin")
	cascmap.attach(homstrombtn,0,1,10,11)
	cascmap.attach(sennabtn,1,2,10,11)
	cascmap.attach(samsonovbtn,2,3,10,11)
	cascmap.attach(lidstormbtn,3,4,10,11)
	cascmap.attach(modinbtn,4,5,10,11)
	
	cumiskeybtn = Gtk::Label.new("cumiskey")
	statsnybtn = Gtk::Label.new("statsny")
	saleibtn = Gtk::Label.new("salei")
	budajbtn = Gtk::Label.new("budaj")
	lilesbtn = Gtk::Label.new("liles")
	cascmap.attach(cumiskeybtn,0,1,11,12)
	cascmap.attach(statsnybtn,1,2,11,12)
	cascmap.attach(saleibtn,2,3,11,12)
	cascmap.attach(budajbtn,3,4,11,12)
	cascmap.attach(lilesbtn,4,5,11,12)
	
	## RHS of west lab
	scavenbtn = Gtk::Label.new("scaven")
	sloybtn = Gtk::Label.new("sloy")
	alshbtn = Gtk::Label.new("alsh")
	woodendbtn = Gtk::Label.new("woodend")
	modupebtn = Gtk::Label.new("modupe")
	cascmap.attach(scavenbtn,6,7,5,6)
	cascmap.attach(sloybtn,7,8,5,6)
	cascmap.attach(alshbtn,8,9,5,6)
	cascmap.attach(woodendbtn,9,10,5,6)
	cascmap.attach(modupebtn,10,11,5,6)
	
	brittlebtn = Gtk::Label.new("brittle")
	wharralbtn = Gtk::Label.new("wharral")
	boisdalebtn = Gtk::Label.new("boisdale")
	bracadalebtn = Gtk::Label.new("bracadale")
	col3btn = Gtk::Label.new("COLUMN")
	cascmap.attach(brittlebtn,6,7,6,7)
	cascmap.attach(wharralbtn,7,8,6,7)
	cascmap.attach(boisdalebtn,8,9,6,7)
	cascmap.attach(bracadalebtn,9,10,6,7)
	cascmap.attach(col3btn,10,11,6,7)
	
	buiebtn = Gtk::Label.new("buie")
	duichbtn = Gtk::Label.new("duich")
	emptybtn = Gtk::Label.new("<empty desk>")
	creranbtn = Gtk::Label.new("creran")
	carronbtn = Gtk::Label.new("carron")
	cascmap.attach(buiebtn,6,7,7,8)
	cascmap.attach(duichbtn,7,8,7,8)
	cascmap.attach(emptybtn,8,9,7,8)
	cascmap.attach(creranbtn,9,10,7,8)
	cascmap.attach(carronbtn,10,11,7,8)
	
	ledinbtn = Gtk::Label.new("ledin")
	svatosbtn = Gtk::Label.new("svatos")
	kovalevbtn = Gtk::Label.new("kovalev")
	wolskibtn = Gtk::Label.new("wolski")
	prospalbtn = Gtk::Label.new("prospal")
	cascmap.attach(ledinbtn,6,7,8,9)
	cascmap.attach(svatosbtn,7,8,8,9)
	cascmap.attach(kovalevbtn,8,9,8,9)
	cascmap.attach(wolskibtn,9,10,8,9)
	cascmap.attach(prospalbtn,10,11,8,9)
	
	######## END MACHINES

	exitbtn = Gtk::Button.new("Close")
   	exitbtn.signal_connect("clicked") {
   		cascwindow.destroy
   	}
   	
   	cascwindow.border_width = 10
   	cascwindow.add(cascmap)
	
	update_map(hostname,cascaders,cascmap)
	
	cascmap.attach(exitbtn,8,9,2,3)
	cascwindow.show_all
end
