// Inherit the parent event
event_inherited();

start_hit_sizex = 6;
start_hit_sizey = 6;
hit_sizex = start_hit_sizex;
hit_sizey = start_hit_sizey;
targeting_player = noone;

ceiling_falling = false;

ceiling = noone;
in_shell = 0;

koopaEscapeShell.Connect( self, function() {
	ysc=1;
});

enemyRolledInto.Destroy();

enemyRolledInto.Connect( self, function(hit_p) {
	with(hit_p) {
		if (state!="boarding") {
			vsp = -(abs(hsp)*1.25);
		} else {
			vsp = -(abs(hsp)*2);
		}
		hsp /= 1.5;
		grounded=false;
		canstopjump=true;
	}
	phaseid=hit_p.id;
	phase_leeway=3;
	
	if !(in_shell) || (shell_move) {
		VinylPlay(snd_enemykick);
		with(hit_p) {
			make_particle(pImpact,x+hit_sizex*xsc,y,-5);
		}
		constantspd = 0;
		enemycoll = true;
		y += (start_hit_sizey-6); //Pulling the shell to the ground
		in_shell = shell_time;
		no_stomping = true
		shell_move = false
		rolled_into = true;
	}
});

exitPipe.Connect( self, function(carry_p) {
	attach_to_ceiling = false;
	onceiling = false;
	grounded = false;
	ysc = 1;
	attach_to_ceiling = false;
	grav=defaultgrav;
});
