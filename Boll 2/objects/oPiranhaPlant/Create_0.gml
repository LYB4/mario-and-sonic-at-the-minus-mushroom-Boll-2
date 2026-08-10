event_inherited()
hit_sizey = 8;
travel = 0; //the y level within the pipe
timer = 120;
go = 0; //whether or not it should go up the pipe
exposed = false; //when it has fully exited the pipe
is_shy = true;
visible = true;

escapePipe = new Signal();

enemyRespawn.Connect( self, function(thrown_p) {
	travel = 0;
	timer = 120;
	go = 0.5;
	exposed = false;
});