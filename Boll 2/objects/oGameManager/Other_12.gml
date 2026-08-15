///Starman Music Start
if (!is_undefined(fgMusic) && VinylIsPlaying(fgMusic))
	VinylStop(fgMusic);
if (!is_undefined(bgMusic) && VinylIsPlaying(bgMusic))
	VinylStop(bgMusic);
fgMusic=VinylPlay("starman bgm", true, MUSIC_GAIN*VinylMixGetGain("music"));