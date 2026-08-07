#macro MUSIC_GAIN 0.35
#macro MUSIC_GAIN_INACTIVE_MUFFLED 0.1
#macro MUSIC_GAIN_INACTIVE 0.225

global.yellow_switch=0;
global.cyan_switch=0;
global.magenta_switch=0;
global.coins_collected=0;
global.paused=0;
global.conductive_array=[oAmp]

piping_object_depth = 0;

shard_count = 0;
collected_shards = [];

HUDsurface=-1;
gameoversurface=-1;

HUDcoinflash=0;

game_timer = 0;

level_properties =
{
    name : "Danger Room",
    desc : "",
	music_track: "floragrande"
};

reserved_item = noone;
reserve_timer = 0;

var guiw = window_get_width();
var guih = window_get_height();
if !os_is_paused() && guiw>0 && guih>0 {
	HUDsurface=surface_create(RESOLUTION_X,RESOLUTION_Y)
}
bgMusic=undefined;
fgMusic=undefined;
bluefadeprog = shader_get_uniform(shd_bluefade, "staged_offset");
bluefadeinflag = shader_get_uniform(shd_bluefade, "fadein");

fadeprog = 0.0
fadein = false

enable_app_surf_redraw = false

hidden_tile_layers = [];

all_layers = [];