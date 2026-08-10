event_inherited();

image_xscale=esign(hsp,1)

if !on_screen(32,32) {
	instance_destroy();
}
var checkside=hit_sizex*sign(hsp)

var coll=collision_line(x+checkside,y-hit_sizey,x+checkside,y+hit_sizey+vsp,[oFrozenItem,oFrozenEnemy],false,true)
if (coll) {
	with(coll) {
		event_user(0);
	}
	instance_create_depth(x+hsp,y+vsp,0,pFireballExplosion)
	instance_destroy();
}

if check_collision_rectangle(x-hit_sizex,y-hit_sizey,x+hit_sizex,y+hit_sizey) {
	instance_create_depth(x+hsp,y+vsp,0,pFireballExplosion)
	instance_destroy();
}

y+=vsp
x+=hsp