hsp = 0
vsp = 0
gsp = 0
grav = 0.2
grounded = 0;
bounce = false;
hit_sizex = 8;
hit_sizey = 8;
bounce_speed = vsp;
myregion=0;
going=0;
collision_array=[oCollider, oBarrier];
parentblock = noone;

depth = 5;

node_init_vars();

physics_enabled = false;
bumpable = false;

blockHit = new Signal();

blockHit.Connect( self, function(hit_p, obj) {
	oGameManager.pswitch_timer = 60 * 10;
	
	instance_create_depth(x,y,depth, oPSwitchDead)
	
	instance_activate_object(oBrick);
	instance_activate_object(oCoin);
	var bricks, coins, c = 0;
	bricks = -1; coins = -1
	with (oBrick) {
		var pstruct = getnodevars();
		bricks[c++] = pstruct;
		bricks[c++] = depth;
		bricks[c++] = y;
		bricks[c++] = x;
		
		instance_destroy();
	}
	
	c = 0
	
	with (oCoin) {
		var pstruct = getnodevars();
		coins[c++] = pstruct;
		coins[c++] = depth;
		coins[c++] = y;
		coins[c++] = x;
		
		instance_destroy();
	}
	
	if (bricks != 1) {
		c = 0; 
		while (c < array_length(bricks)) {
			instance_create_depth(bricks[c++], bricks[c++], bricks[c++], oCoin, bricks[c++]);
		}
	}
	
	if (coins != -1) {
		c = 0; 
		while (c < array_length(coins)) {
			instance_create_depth(coins[c++], coins[c++], coins[c++], oBrick, coins[c++]);
		}
	}
	
	VinylPlay(snd_switch);
	instance_destroy();
});