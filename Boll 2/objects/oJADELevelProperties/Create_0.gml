//show_message("JADE levproprtywindow")

//Music tracks list
music_real_list=[
"floragrande",
"frigiddark"
]

image_xscale = 320;
image_yscale = 200;

x -= image_xscale/2;
y -= image_yscale/2;

exitbutton = new JADEiconbutton(x+image_xscale-16,y+1,spr_JADEexiticon, function() {
	instance_destroy(oJADELevelProperties);
	oJADEController.topbuttons.reset();
});

//auto generation the list of names for dropdown, dont touch!
musicnames=[];
var i=0;
repeat(array_length(music_real_list)) {
	array_push(musicnames, global.musiclist[$ music_real_list[i]].formatted_name)
	i++;
}
//show_message(array_length(musicnames))

musicselector = new JADEsmallbuttons(x,y+72,160,16)
musicselector.add("Select music track", function() {
	var inst = JADEdropdown(musicselector.x,musicselector.y+musicselector.height+4,musicnames, function(name,ind) {
		if (ind!=-1) {
			oJADEController.level_properties.music_track=music_real_list[ind];
		}
		oJADELevelProperties.musicselector.reset();
	});
	inst.depth=oJADELevelProperties.depth-1;
});

/*
//auto generation the list of names for dropdown, dont touch!
tilesetnames=[];
var i=0;
repeat(array_length(tilesetlist)) {
	array_push(tilesetnames, global.tilesets[$ tilesetlist[i]][2])
	i++;
}

tilesetselector = new JADEsmallbuttons(x,y+66,52,16)
tilesetselector.add("Select", function() {
	var inst = JADEdropdown(tilesetselector.x,tilesetselector.y+tilesetselector.height+4,tilesetnames, function(name,ind) {
		if (ind!=-1) {
			selected_layer.update_tileset(tilesetlist[ind]);
			oJADEController.current_tileset=selected_layer.tileset;
			oJADEController.tilepicker.pan_x = 0;
			oJADEController.tilepicker.pan_y = 0;
		}
		oJADELayerProperties.tilesetselector.reset();
	});
	inst.depth=oJADELayerProperties.depth-1;
});
 */
