// Inherit the parent event
event_inherited();

if (stun) {
	stun=max(stun-1,0);

	if !(stun) {
		onStunRecover.Emit();
	}
}

if (instance_exists(mylog)) {
	mylog.x = x;
	mylog.y = y-mylog.hit_sizey-8;
	mylog.xsc = xsc;
}