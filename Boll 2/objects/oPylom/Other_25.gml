// Inherit the parent event
event_inherited();

ammo = maxammo;
with(mylog) {
	image_yscale=0.5*other.maxammo;
	goto_yscale = image_yscale;
	hit_sizey = sprite_height/2;
}