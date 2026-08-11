event_inherited();

hit_sizex=4
hit_sizey=4
vsp=0
hsp=0
gsp=0
grounded=false
grav=0.25
piped=false
collision_array=[oCollider]
owner=-1;

fizzle = new Signal();

fizzle.Connect( self, function() {
	instance_create_depth(x+hsp,y+vsp,0,pFireballExplosion)
	instance_destroy();
});