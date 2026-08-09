global.player_spritelists[0]=[]
var i=0;
repeat (1000) {
	global.channelid[i]=0
	i++;
}

PlayerColl=new Collage("Players", 4096, 4096, false, 1, true)
CustomColl=new Collage("Custom", 4096, 4096, false, 1, true)
import_sheets();
enable_app_surf_redraw = true
if room==rGame {
	instance_create_depth(0,0,0,oBackgroundManager);
	instance_create_depth(0,0,0,oNodeManager);
	instance_create_depth(0,0,0,oDrawingManager);

	global.warptimer=0;
	global.yellow_switch=0;
	global.cyan_switch=0;
	global.magenta_switch=0;
	//enable_app_surf_redraw = true
	//instance_create_depth(0,0,depth -1,oTitlecard);
} 

var w = RESOLUTION_X*global.settings[$ "resolution_scale"];
var h = RESOLUTION_Y*global.settings[$ "resolution_scale"];

if (global.settings[$ "fullscreen_type"]) {
	w = display_get_width();
	h = display_get_height();
}

var mode = STANNCAM_WINDOW_MODE.WINDOWED;

if (global.settings[$ "fullscreen_type"]==1) {
	mode = STANNCAM_WINDOW_MODE.BORDERLESS;
} else if (global.settings[$ "fullscreen_type"]==2) {
	mode = STANNCAM_WINDOW_MODE.FULLSCREEN;
}

parse_level(global.nextlevel)
instance_activate_object(oShard)
var maxid = -1;
with(oShard) {
	if (shardid > maxid) {
		maxid = shardid
		other.shard_count++;
	}
}
collected_shards = array_create(shard_count,0);