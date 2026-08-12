event_inherited();
hsp = 0
vsp = 0
gsp = 0
grav = 0.2
grounded = 0;
bounce = false
hit_sizex = 8
hit_sizey = 8
bounce_speed = vsp
collision_array=[oCollider, oBarrier];

physics_enabled = false;
bumpable = false;

image_speed = 0.25;

blockHit.Destroy();

blockHit.Connect( self, function(hit_p, obj) {
	var brkvsp = 0;
	var broken_player = noone;
	if (obj.object_index == oPlayer) {
		broken_player = obj
		if ((obj.y-hit_sizey >= bbox_bottom+obj.vsp) && obj.vsp < 0 && !obj.grounded) {
			//ok so the problem is this cant work for now under semisolids,
			//as its an issue with the general collision system so it will never work until thats fixed
			brkvsp = -3;
			if (bumpable) {
				vsp = brkvsp;
				physics_enabled = true;
				bumpable = false;
				exit;
			}
		}
	} else if (obj.object_index == oKoopa) || object_is_ancestor(obj.object_index,oKoopa) {
		if (obj.in_shell) {
			broken_player = obj.kickedplayer
		}
	}
	
	oGameManager.pswitch_timer = 60 * 10;
	
	instance_create_depth(x,y,depth + 5, oPSwitchDead)
	
	instance_activate_object(oBrick);
	instance_activate_object(oCoin);
	show_debug_message("Pswitch hit");
	var bricks, coins, c = 0;
	bricks = -1; coins = -1
	with (oBrick) {
		// pstruct
		if (!variable_instance_exists(self.id, "pathcanfall"))
			node_init_vars();
		scr_pathingstruct();
		bricks[c++] = pstruct;
		bricks[c++] = depth;
		bricks[c++] = y;
		bricks[c++] = x;
		
		instance_destroy();
	}
	
	c = 0
	
	with (oCoin) {
		// pstruct
		if (!variable_instance_exists(self.id, "pathcanfall"))
			node_init_vars();
		scr_pathingstruct();
		bricks[c++] = pstruct;
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
			instance_create_depth(coins[c++], coins[c++], coins[c++], oBrick, bricks[c++]);
		}
	}
	
	VinylPlay(snd_switch);
	instance_create_depth(x,y,0,pSmoke);
	instance_destroy();
});