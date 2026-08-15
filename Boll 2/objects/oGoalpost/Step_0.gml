signpost_angle=wrap_val(signpost_angle+signpost_spd,0,359);

if (signpost_spd) {
	signpost_spd = approach_val(signpost_spd,2,0.075);

	if (signpost_spd <= 2) {
		if (within(round(signpost_angle),179,181)) {
			signpost_spd = 0;
			signpost_angle = 180;
			onFinish.Emit();
		}
	}
}

if (signpost_going) {
	signpost_y -= signpost_vsp;
	
	if (signpost_y <= signpost_goto) {
		VinylPlay(snd_signpostbounce,0,1,(signpost_vsp/4)+0.5);
		if (abs(signpost_vsp) > 0.2) {
			signpost_vsp = -(signpost_vsp/2);
			signpost_y = signpost_goto;
		} else {
	        signpost_vsp = 0;
	        signpost_y = signpost_goto;
			signpost_going = false;
	    }
	}
	
	signpost_vsp += 0.1;
}

if (belltimer > 0) {
	belltimer -= bellspeed;
	bellspeed = max(bellspeed-0.01,0.1);
	
	if !(belltimer) {
		belltimer = 0;
	}
}