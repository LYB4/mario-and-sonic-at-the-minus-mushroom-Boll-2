image_xscale = 384;
image_yscale = 240;

x -= image_xscale/2;
y -= image_yscale/2;

regionlist = new JADElisthandler(x,y+20,96,image_yscale-30,"selected_region");

exitbutton = new JADEiconbutton(x+image_xscale-16,y+1,spr_JADEexiticon, function() {
	instance_destroy(oJADERegionProperties);
	oJADEController.topbuttons.reset();
});

newregionbutton = new JADEiconbutton(x+116,y+24,spr_JADEaddiconsmall, function() {
	var newregion = new JADEregion(27,16,$"Region {array_length(oJADEController.regions)+1}")
	newregion.mylayerlist.add(new JADElistunselectable("Objects"))
	newregion.mylayerlist.add(new JADElistunselectable("Piping Objects"))
	newregion.mylayerlist.add(new JADEtilelayer("Main Tiles", "tTilesetMain",newregion.get_width(),newregion.get_height()))
	newregion.mylayerlist.add(new JADEbackgroundlayer("Sky", oJADEController.obj_data[$ "spr_plains_bg_sky"]))
	newregion.mylayerlist.update_depths();
	array_push(oJADEController.regions,newregion);
	newregionbutton.reset();
});