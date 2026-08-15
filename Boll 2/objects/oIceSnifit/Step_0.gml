// Inherit the parent event
event_inherited();

cooldowntimer=max(cooldowntimer-1,0);

var pl=nearestplayer()

if (pl) && !(stun) && !(blowing) && !(cooldowntimer) && (abs(pl.x-x) <= 192) && (within(pl.y,y-64,y+64)) && !(revving) {
	revving=true;
	revtimer=50;
	constantspd=0;
	freeze_hitbox = 0;
	var olddir = _direction;
	var newdir = esign(pl.x-x,-xsc);
	if (olddir != newdir) {
		enemyTurnAround.Emit();
		xsc=-_direction;
	}
}

if (revving) && !(turning) {
	revtimer=max(revtimer-1,0)
	
	if !(revtimer) {
		revving=false;
		blowing=true
		blowtimer=90;
	}
}