function warp_in_pipe(obj,spd,dir) {
	no_step = true;
	piped=true;
	if (warp_timer == -1) exit;
	
	x+=lengthdir_x(spd,dir)
	y+=lengthdir_y(spd,dir)
	depth=oGameManager.piping_object_depth[myregion]; //behind all main tiles
	
	//my_camera.set_paused(true);
	
	warp_timer=approach_val(warp_timer,0,1)
	
	if (warp_timer == 30) {
		visible=0
		FadeTransition(0.5,function() {
			with(oPlayer) {
				if (piped) && !(warp_out) {
					warp_transition()
				}
			}
		})
		var found = warp_coll.mytargetpipe //predicting the camera position
		instance_activate_object(found);
		if (found.myregion == myregion) {
			var xx = x;
			var yy = y;
			if instance_exists(found) {
				xx=found.x;
				if found.image_angle!=90 && found.image_angle!=270
				yy=found.y;
				else
				yy=found.y+4;
			} else {
				xx=warp_coll.x;
				if warp_coll.image_angle!=90 && warp_coll.image_angle!=270
				yy=warp_coll.y;
				else
				yy=warp_coll.y+4;
			}
			my_camera.move(xx,yy,30);
		}
	}
	
	if (!warp_timer) {
		warp_timer = -1;
	}
}

function warp_transition() {
	var warping_from = warp_coll;
	var found = warp_coll.mytargetpipe;
	instance_activate_object(found);
	if instance_exists(found) { //warp to found pipe
		warp_coll = found;
		switch (warp_coll.object_index) {
			case oPipe:
				x=warp_coll.x;
				if warp_coll.image_angle!=90 && warp_coll.image_angle!=270
				y=warp_coll.y;
				else
				y=warp_coll.y+4;
				if (warp_coll.myregion != myregion) {
					myregion=warp_coll.myregion;
					depth = oGameManager.piping_object_depth[myregion]; //behind all main tiles
				
					with(oGameManager) {
						switch_region(other.myregion);
					}
				
					var xx = x;
					var yy = y;
					xx=warp_coll.x;
					if warp_coll.image_angle!=90 && warp_coll.image_angle!=270
					yy=warp_coll.y
					else
					yy=warp_coll.y+4;
			
					my_camera.move(xx,yy,0);
				}
			
				if (warp_coll.image_angle == 90) {
					xsc = -1;
				}
			
				if (warp_coll.image_angle == 270) {
					xsc = 1;
				}
			break;
			case oWarpDestination:
				myregion=warp_coll.myregion;
				if (warp_coll.myregion != myregion) {
					with(oGameManager) {
						switch_region(other.myregion);
					}
					my_camera.move(x,y,0);
				} else {
					if (warping_from.object_index != oFadeWarpArea) {
						my_camera.move(x,y,30);
					} else {
						my_camera.move(x,y,0);
					}
				}
				x=warp_coll.x;
				y=warp_coll.y;
			break;
		}
	} else { //if pipe is for some reason, not found, send back to original pipe
		switch(warp_coll.object_index) {
			case oPipe:
				x=warp_coll.x
				if warp_coll.image_angle!=90 && warp_coll.image_angle!=270
				y=warp_coll.y
				else
				y=warp_coll.y+4
			break;
			case oFadeWarpArea:
				piped = false;
			break;
		}
	}
	
	warp_type="";
	switch(warp_coll.object_index) {
		case oPipe:
			switch(warp_coll.image_angle) {
				case 0:
					warp_type="exit_pipe_up";
				break;
				case 180:
					warp_type="exit_pipe_down";
				break;
				case 90:
				case 270:
					warp_type="exit_pipe_side";
				break;
			}
			piped=true;
			warp_out=true;
			warp_timer=21; //very hacky value
			visible=true;
		break;
		case oWarpDestination:
			grounded = false;
			gsp = 0;
			hsp = 0;
			vsp = 0;
			visible = false;
			piped = true;
			if !(warp_coll.delay) {
				piped=false;
				warp_out=false;
				warp_timer=0;
				visible=true;
				warp_coll=noone;
			
				if (warp_coll.launchpower) {
					ignore_collision = 15;
					VinylPlay(snd_enemycannon);
					canstopjump = true; 
					hsp = lengthdir_x(warp_coll.launchpower*2,warp_coll.launchdirection);
					vsp = lengthdir_y(warp_coll.launchpower*2,warp_coll.launchdirection);
					state = "jump";
					sig.Emit("warp_launch");
				}
			} else {
				warp_coll.delayWarp();
			}
		break;
	}
}

function warp_out_pipe(obj,spd,dir) {
	no_step = true;
	piped=true;
	x+=lengthdir_x(spd,dir)
	y+=lengthdir_y(spd,dir)
	if !collision_rectangle(x-hit_sizex-4,y-hit_sizey-4,x+hit_sizex-4,y+hit_sizey, obj, false, true) {
		piped=false
		warp_timer=0;
		warp_coll=noone;
		warp_out=false;
		hsp = 0;
		gsp = 0;
		vsp = 0;
		move = 0;
		state = "";
		depth = 0;
		visible=true;
		warp_type = "";
		VinylPlay(snd_pipe)
		sig.Emit("exit_pipe")
		//my_camera.set_paused(false);
		no_step = false;
	}
}

function player_warping() {
	if (dead || hurt) exit;
	
	//THIS SUCKS!!!!!!!!!
	var pipecoll=collision_line(x-hit_sizex,y+hit_sizey+1,x+hit_sizex,y+hit_sizey+1,oPipe,false,true)
	if (pipecoll && pipecoll.image_angle==0 && pipecoll.warptarget!="" && (abs(x-pipecoll.x) <= 8)) { //WARPING DOWN PIPE
		if (down) && !(piped) && (grounded) && !(warp_coll) {
			piped=true
			warp_type="enter_pipe_down"
			warp_timer=90;
			warp_coll=pipecoll
			x=pipecoll.x
			hsp = 0;
			gsp = 0;
			vsp = 0;
			move = 0;
			state = "";
			VinylPlay(snd_pipe)
			sig.Emit("enter_pipe")
			my_camera.move(pipecoll.x,pipecoll.y,30);
		}
	}
	pipecoll=collision_line(x+hit_sizex+1,y-hit_sizey,x+hit_sizex+1,y+hit_sizey,oPipe,false,true)
	if (pipecoll && pipecoll.image_angle==90 && pipecoll.warptarget!="") { //WARPING RIGHT PIPE
		if (right) && !(piped) && (grounded) && !(warp_coll) {
			piped=true
			warp_type="enter_pipe_side"
			warp_timer=90;
			warp_coll=pipecoll
			y=pipecoll.y+4
			hsp = 0;
			gsp = 0;
			vsp = 0;
			move = 0;
			state = "";
			VinylPlay(snd_pipe)
			sig.Emit("enter_pipe")
			my_camera.move(pipecoll.x,pipecoll.y,30);
		}
	}
	pipecoll=collision_line(x-hit_sizex-1,y-hit_sizey,x-hit_sizex-1,y+hit_sizey,oPipe,false,true)
	if (pipecoll && pipecoll.image_angle==270 && pipecoll.warptarget!="") { //WARPING LEFT PIPE
		if (left) && !(piped) && (grounded) && !(warp_coll) {
			piped=true
			warp_type="enter_pipe_side"
			warp_timer=90;
			warp_coll=pipecoll
			y=pipecoll.y+4
			hsp = 0;
			gsp = 0;
			vsp = 0;
			move = 0;
			state = "";
			VinylPlay(snd_pipe)
			sig.Emit("enter_pipe")
			my_camera.move(pipecoll.x,pipecoll.y,30);
		}
	}
	pipecoll=collision_rectangle(x-hit_sizex,y-hit_sizey-3,x+hit_sizex,y-hit_sizey-1,oPipe,false,true)
	if (pipecoll && pipecoll.image_angle==180 && pipecoll.warptarget!="" && (abs(x-pipecoll.x) <= 8)) { //WARPING UP PIPE
		if (up) && !(piped) && !(warp_coll) {
			piped=true
			warp_type="enter_pipe_up"
			warp_timer=120;
			warp_coll=pipecoll
			x=pipecoll.x;
			hsp = 0;
			vsp = 0;
			state = "";
			VinylPlay(snd_pipe)
			sig.Emit("enter_pipe")
			my_camera.move(pipecoll.x,pipecoll.y,30);
		}
	}
	if (warp_coll) && (warp_timer) && (piped) {
		instance_activate_object(warp_coll)
		if (warp_coll.object_index == oPipe) {
			if !(warp_out) {
				warp_in_pipe(warp_coll,0.5,wrap_val(warp_coll.image_angle-90,0,359))
			} else {
				warp_out_pipe(warp_coll,0.5,warp_coll.image_angle+90)
			}
		}
	}
}