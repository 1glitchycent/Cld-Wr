/datum/wires/autolathe
	holder_type = /obj/machinery/autolathe
	proper_name = "Autolathe"


/datum/wires/autolathe/New(atom/holder)
	wires = list(
		WIRE_HACK, WIRE_DISABLE,
		WIRE_SHOCK, WIRE_ZAP
	)
	add_duds(6)
	return ..()


/datum/wires/autolathe/interactable(mob/user)
	var/obj/machinery/autolathe/A = holder
	if(A.panel_open)
		return TRUE


/datum/wires/autolathe/get_status()
	var/obj/machinery/autolathe/A = holder
	var/status
	status += "The red light is [A.disabled ? "on" : "off"].<br>"
	status += "The blue light is [A.hacked ? "on" : "off"]."
	return status


/datum/wires/autolathe/on_pulse(wire)
	. = ..()
	if(!.)
		return

	var/obj/machinery/autolathe/A = holder
	switch(wire)
		if(WIRE_HACK)
			A.hacked = !A.hacked
			addtimer(CALLBACK(A, /obj/machinery/autolathe.proc/reset, wire), 60)
		if(WIRE_SHOCK)
			A.shocked = !A.shocked
			addtimer(CALLBACK(A, /obj/machinery/autolathe.proc/reset, wire), 60)
		if(WIRE_DISABLE)
			A.disabled = !A.disabled
			addtimer(CALLBACK(A, /obj/machinery/autolathe.proc/reset, wire), 60)


/datum/wires/autolathe/on_cut(wire, mend)
	. = ..()
	if(!.)
		return
		
	var/obj/machinery/autolathe/A = holder
	switch(wire)
		if(WIRE_HACK)
			A.hacked = !mend
		if(WIRE_HACK)
			A.shocked = !mend
		if(WIRE_DISABLE)
			A.disabled = !mend
		if(WIRE_ZAP)
			A.shock(usr, 50)