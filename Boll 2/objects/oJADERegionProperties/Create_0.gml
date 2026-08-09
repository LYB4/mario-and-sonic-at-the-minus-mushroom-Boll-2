image_xscale = 384;
image_yscale = 240;

x -= image_xscale/2;
y -= image_yscale/2;

//Music tracks list
music_real_list=[
"floragrande",
"frigiddark"
]

//auto generation the list of names for dropdown, dont touch!
musicnames=[];
var i=0;
repeat(array_length(music_real_list)) {
	array_push(musicnames, global.musiclist[$ music_real_list[i]].formatted_name)
	i++;
}

musicselector = new JADEsmallbuttons(x+114,y+82,160,16)
musicselector.add("Select Music Track", function() {
	var inst = JADEdropdown(musicselector.x,musicselector.y+musicselector.height+4,musicnames,function(name,ind) {
		if (ind!=-1) {
			oJADEController.regions[oJADEController.selected_region].music_track=music_real_list[ind];
		}
		musicselector.reset();
	});
	inst.depth=depth-1;
});


regionlist = new JADElisthandler(x,y+20,96,image_yscale-30,"selected_region");

exitbutton = new JADEiconbutton(x+image_xscale-16,y+1,spr_JADEexiticon, function() {
	instance_destroy(oJADERegionProperties);
	oJADEController.topbuttons.reset();
});

newregionbutton = new JADEiconbutton(x+116,y+24,spr_JADEaddiconsmall, function() {
	var newregion = new JADEregion(27,16,$"Region {array_length(oJADEController.regions)+1}")
	newregion.mylayerlist.add(new JADElistunselectable("Objects"))
	newregion.mylayerlist.add(new JADElistunselectable("Piping Objects"))
	newregion.mylayerlist.add(new JADEtilelayer("Main Tiles", "tTilesetMain",newregion.width,newregion.height))
	newregion.mylayerlist.add(new JADEbackgroundlayer("Sky", oJADEController.obj_data[$ "spr_plains_bg_sky"]))
	newregion.mylayerlist.update_depths();
	newregion.mylayerlist.hide();
	array_push(oJADEController.regions,newregion);
	newregionbutton.reset();
	oJADEController.regions[oJADEController.selected_region].mylayerlist.show();
});

deletebutton = new JADEiconbutton(x+116,y+44,spr_JADEdeleteiconsmall, function() {
	with(oJADEController) {
		if (array_length(regions) > 1) {
			var region = regions[selected_region];
			region.cleanup();
			delete region;
			array_delete(regions,selected_region,1);
			selected_region=max(selected_region-1,0);
			update_region();
		}
	}
	deletebutton.reset();
});