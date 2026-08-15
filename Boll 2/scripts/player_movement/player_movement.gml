function player_movement(){
	if (piped) || (electrocuted) || (electrocution_timer) exit
	
	if !(no_move)
	move = (right - left);
	
	if (move != 0) && !(steep_slope || no_move || move_lock)
	{	
		//dont walk up a slope if its too steep to walk on
		
		if grounded {
			var signmatch = (check_signs_matching_zero(gsp, move))
			var accel_real = ((skidding) ? skid_accel : ((signmatch) ? accel : fastaccel));
			if ((signmatch && abs(gsp) < topspd) || !signmatch) {
				gsp += (move * accel_real);
			}
		} else {
			//whether or not to use sonic or mario air physics
			if !(sonic_air_momentum) {
				var signmatch = (check_signs_matching(hsp, move))
				var accel_real = accel;
				if ((signmatch && abs(hsp) < topspd) || !signmatch) {
					hsp += (move * accel_real);
				}
			} else {
				if (vsp < 0 && vsp > -2 ) {
					hsp -= hsp / 32
				}
			}
		}
		
	}
	else
	{
		//move=0 //just in case
		// chearii: mhomentunmnm
		if (grounded) {
			var _fric = fric * friction_mult;
			if ((crouch || state == "crouch") && friction_mult < 1) {
				_fric *= friction_mult;
			}
			if (skidding && friction_mult < 1) {
				_fric *= friction_mult;
			}
			if (sign(gsp) = -1) {
				gsp = min(0, gsp + _fric)
			} else {
				gsp = max(0, gsp - _fric)
			}
		}
	}
	
	if (abs(gsp) > maxspd) && (grounded) gsp=approach_val(gsp, maxspd * sign(gsp), 0.5) 
	if (abs(hsp) > maxspd) && (!grounded) hsp=approach_val(hsp, maxspd * sign(hsp), 0.5)
	
	if (grounded) {
		pollenated = false;
		if sign(gsp)!=sign(colslope) {
			vsp = gsp * -dsin(colangle)
			hsp = gsp * dcos(colangle)
		} else if dsin(colangle)!=0 && dcos(colangle)!=0 && dcos(colangle)<1 && (abs(colslope) == 1) {
			vsp = gsp / -(dsin(colangle) * 1.25)
			hsp = gsp / (dcos(colangle) * 1.25)
		} else {
			hsp = gsp; //fix for hsp being delayed by 1 frame all the time (no more sliding along the floor)	
		}
		
		if (abs(gsp)!=0.0) {
			sample_footstep_material();
			play_footstep();
		}
	} else {
		pushing = false;
		
		if (abs(hsp) > topspd) && (grounded || apply_speedcap_midair) {
			if (vsp < 0 && vsp > -2 ) {
				hsp -= hsp / 32
			}
		}
	}
	
	if (pollenated) {
		vsp=min(vsp,1)
	}
}