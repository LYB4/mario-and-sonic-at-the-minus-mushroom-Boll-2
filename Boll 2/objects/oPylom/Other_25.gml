// Inherit the parent event
event_inherited();
y-=2;

ammo = maxammo;
with(mylog) {
	image_yscale=0.5*other.maxammo;
	goto_yscale = image_yscale;
	hit_sizey = sprite_height/2;
}

if (flipped) {
	_direction = -_direction;
	xsc=-_direction;
}

if (standby) {
	constantspd = 0
}