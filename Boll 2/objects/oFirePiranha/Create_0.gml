event_inherited()
is_shy = true;

shot = false;

overridexsc = true;

face_dir = 0;

escapePipe.Connect( self, function(thrown_p) {
	var inst = instance_create_depth(x,y,4,oDirectionalFireball);
	if (rot mod 180 == 0) {
		var mult = 1;
		if (rot == 180) mult = -1;
		
		inst.hsp = -xsc*mult;
		inst.vsp = (face_dir*0.5)*mult;
		inst.x -= 8*(xsc*mult);
		inst.y -= 2*(xsc*mult);
	} else {
		var mult = 1;
		if (rot == 270) mult = -1;
		
		inst.hsp = (face_dir*0.5)*mult;
		inst.vsp = xsc*mult;
		inst.y += 8*(xsc*mult);
		inst.x += 2*(xsc*mult);
	}
	shot = true;
	event_user(0);
});

enemyRespawn.Connect( self, function(thrown_p) {
	travel = 0;
	timer = 120;
	go = 0.5;
	exposed = false;
});