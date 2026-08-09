event_inherited()
hit_sizey = (bbox_bottom - bbox_top) div 2
travel = 0; //the y level within the pipe
timer = 120;
go = 0.5; //whether or not it should go up the pipe
exposed = false; //when it has fully exited the pipe
is_shy = true;

enemyRespawn.Connect( self, function(thrown_p) {
	travel = 0;
	timer = 120;
	go = 0.5;
	exposed = false;
});