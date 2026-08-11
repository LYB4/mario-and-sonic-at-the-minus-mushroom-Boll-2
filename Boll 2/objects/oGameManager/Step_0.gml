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