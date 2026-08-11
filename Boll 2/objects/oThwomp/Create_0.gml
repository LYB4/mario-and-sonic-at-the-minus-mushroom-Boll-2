event_inherited();

enemyFireballed.Destroy();

state = 0;
frame = 0;
timer_offset = 0;

hit_sizex=14;
hit_sizey=14;

enemySpinjumped.Destroy();

enemySpinjumped.Connect( self, function(hit_p) {
	with(hit_p) {
		instance_create_depth(x,y+hit_sizey,-5,pImpact)
		sig.Emit("enemy_spinjumped");
	}
	VinylPlay(snd_enemyspinjump_reflect)
	phaseid=hit_p;
	phase_leeway=7;
});