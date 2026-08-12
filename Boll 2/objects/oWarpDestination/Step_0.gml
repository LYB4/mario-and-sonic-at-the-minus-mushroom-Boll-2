if (delay) && (going) {
	timer = max(timer-1,0);

	if !(timer) {
		timer = delay;
		going = false;
		with(oPlayer) {
			piped=false;
			warp_out=false;
			warp_timer=0;
			visible=true;
			grounded = false;
			gsp = 0;
			hsp = 0;
			vsp = 0;
			warp_coll=noone;
			
			if (other.launchpower) {
				ignore_collision = 15;
				VinylPlay(snd_enemycannon);
				canstopjump = true; 
				hsp = lengthdir_x(other.launchpower*2,other.launchdirection);
				vsp = lengthdir_y(other.launchpower*2,other.launchdirection);
				state = "jump";
				sig.Emit("warp_launch");
			}
		}
	}
}