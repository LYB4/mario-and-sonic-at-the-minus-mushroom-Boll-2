if global.paused exit

if (piping) && (object_get_parent(object_index) != oPiranhaPlant && object_index != oPiranhaPlant && object_index != oJumpingPiranha) {
	var spd = 0.5;
	var dir = wrap_val(piping_coll.image_angle-90,0,359)
	x-=lengthdir_x(spd,dir)
	y-=lengthdir_y(spd,dir)
	depth = oGameManager.piping_object_depth[myregion];
	
	if !(collision_rectangle(x-hit_sizex,y-hit_sizey,x+hit_sizex,y+hit_sizey,piping_coll,false,true)) {
		piping = false;
		depth = 4;
	}
	
	event_user(0); //animation controller

	if (sprite_index!=prevsprite_index) {
		event_user(1); //reset frame
	}
	exit;
}

//grounded=false

if !(grabbed) {

if !(spawned_from_pipe) {
	if !on_screen(32,32) && !origin_on_screen(xstart,ystart,32,32) && !(respawned) {
		x = xstart
		y = ystart
		enemyRespawn.Emit();
		respawned=true;
	} else if on_screen(32,32) {
		instance_activate_region(x-activation_region_width, y-activation_region_width, activation_region_width*2, activation_region_height*2, true)
		respawned=false;
	}
}

onceiling = check_collision_line(x-hit_sizex+hsp,y-hit_sizey-6,x+hit_sizex+hsp,y-hit_sizey-6,COL_TOP)

if !(in_shell) && (edgeturn) && (grounded || attach_to_ceiling)
{
	if !(attach_to_ceiling) {
		if !check_collision_rectangle(x + (_direction * (hit_sizex+1)),y,x + (_direction * (hit_sizex-4)),y+hit_sizey+16, COL_BOTTOM) {
			if !(turned) {
				turned=1
				enemyTurnAround.Emit();
			}
		} else {
			turned=0
		}
	} else {
		if !check_collision_rectangle(x + (_direction * (hit_sizex+1)),y,x + (_direction * (hit_sizex-4)),y-hit_sizey-16, COL_TOP) {
			if !(turned) {
				turned=1
				enemyTurnAround.Emit();
			}
		} else {
			turned=0
		}
	}
}

var steely=collision_rectangle(x-hit_sizex,y-hit_sizey,x+hit_sizex,y+hit_sizey, oBigSteely, true, true)

if (steely) && (abs(steely.hsp)>0 || abs(steely.vsp)>0) {
	hp=0
}

if check_collision_line(x+(hit_sizex+1)*_direction, y+(hit_sizey-2),x+(hit_sizex+1)*_direction, y-(hit_sizey-2), COL_WALL) && (has_collision) {
	enemyTurnAround.Emit();
}

if (enemycoll) {
	var coll = check_rectangle_in_hitbox(x+hsp+(hit_sizex+1)*_direction,y+hit_sizey-3,x+hsp+(hit_sizex+1)*_direction,y-hit_sizey+3,oEnemy)
	
	if (coll) && (coll.enemycoll) && !(coll.grabbed) && !(turning) {
		enemyTurnAround.Emit();
	}
}

if !(attach_to_ceiling) {
	if !(grounded)
	{
		vsp=min(vsp+grav,4);
	} else {
		thrown = false;
		carry_player = noone;
		if walker {
			gsp = constantspd * _direction
		}
		if !(no_slope_influence) {
			vsp = gsp * -dsin(colangle)
			hsp = gsp * dcos(colangle)
		}
	}
} else {
	grav=-defaultgrav;
	
	if !(onceiling) {
		attach_to_ceiling=false;
		grav=defaultgrav
	} else {
		if walker {
			gsp = constantspd * _direction
		}
		if !(no_slope_influence) {
			vsp = gsp * -dsin(colangle)
			hsp = gsp * dcos(colangle)
		}
	}
}

var shootblock=collision_rectangle(x-hit_sizex,y-hit_sizey,x+hit_sizex,y+hit_sizey,oShootBlock,false,true)
if (shootblock) && (shootblock.goDirection!=0) && !(phaseid) {
	with(shootblock) {
		instance_create(x,y+(sprite_height/2)*goDirection,pImpact)
	}
	VinylPlay(snd_enemykick)
	hp-=1
	phaseid=shootblock
	phase_leeway=3
}

x += hsp
y += vsp

if (has_collision) {
	player_collision();
}

if !(overridexsc) && !(in_shell)
if (gsp != 0) && (hp > 0) && !(turning) xsc=-esign(gsp,-1)

} else {
	if instance_exists(carry_player) {
		xsc=-carry_player.xsc;
	}
		
	var enemy=check_hitbox_on_hitbox(id,oEnemy)

	if (enemy) { //make sure shell is actually colliding with an enemy before trying to kill the enemy it collided with???
		if !(enemy.unshellable) {
			if (enemy.phaseid==noone || enemy.phaseid.id!=id) {
				instance_create_depth(x+hit_sizex*xsc,y,-5,pImpact)
			
				enemy.hp=0;
				enemy.killtype="spin";
				
				VinylPlay(snd_enemykick,false,1,1);
			}
		}
		
		with(carry_player) {
			is_grabbing = false;
			grabbed_obj = noone;
		}
		instance_destroy();
		killtype="spin";
		killvsp=-1;
		killhsp=carry_player.xsc;
	}
}

prevsprite_index = sprite_index

if (turning) && !(in_shell) && !(no_turn_anim) {
	xsc = -turnxsc;
	image_speed = 0;
}

event_user(0); //animation controller

if (sprite_index!=prevsprite_index) {
	event_user(1); //reset frame
}

if (turning) && !(in_shell) && !(no_turn_anim) {
	flipped = 0;
	turning=max(0,turning-1);
	xsc = -turnxsc;
	if !(turning) {
		image_speed = 1
	}
	image_index = (turning > 5)
} else if (in_shell) {
	turning = 0;
}

if !check_rectangle_in_hitbox(x+(hit_sizex+1)*_direction,y+hit_sizey-3,x+(hit_sizex+1)*_direction,y-hit_sizey+3,oEnemy) && ((!check_collision_line(x+(hit_sizex+1)*_direction,y+hit_sizey-3,x+(hit_sizex+1)*_direction,y-hit_sizey+3,COL_WALL) && has_collision) || !has_collision) {
	flipped = 0;
}