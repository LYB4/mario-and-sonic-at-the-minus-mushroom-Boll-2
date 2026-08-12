var underwaterMusic = false;
with(oPlayer) {
	if in_water() underwaterMusic = true;
}


if VinylIsPlaying(fgMusic) {
	if (underwaterMusic) {
		VinylSetGain(fgMusic, MUSIC_GAIN_INACTIVE_MUFFLED, 0.5)
		if VinylIsPlaying(bgMusic) VinylSetGain(bgMusic, MUSIC_GAIN_INACTIVE*VinylMixGetGain("music"), 0.5)
	} else {
		VinylSetGain(fgMusic, MUSIC_GAIN, 0.5)
		if VinylIsPlaying(bgMusic) VinylSetGain(bgMusic, MUSIC_GAIN*VinylMixGetGain("music"), 0.5)
	}
}

game_timer += delta_time / 1000000;

reserve_timer = lerp(reserve_timer,0,0.2);

if (reserve_timer <= 0.01) {
	reserve_timer = 0;
}

if (pswitch_timer > 0) {
	pswitch_timer--;
	if !(pswitch_timer) { // end
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
		
		if (coins != 1) {
			c = 0; 
			while (c < array_length(coins)) {
				instance_create_depth(coins[c++], coins[c++], coins[c++], oBrick, coins[c++]);
			}
		}
	}
}

if (shard_count) {
	var i=0;
	repeat(array_length(shard_scales)) {
		shard_scales[i] = lerp(shard_scales[i],1,0.2);

		if (shard_scales[i] <= 0.01) {
			shard_scales[i] = 0;
		}
		i++;
	}

	shard_gui_timer=max(shard_gui_timer-1,0);
	if !(shard_gui_timer) {
		shard_gui_goto = -16;
	}
	shard_gui_y=lerp(shard_gui_y,shard_gui_goto,0.2);
}