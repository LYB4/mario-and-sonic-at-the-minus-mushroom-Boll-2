surface_free(GUIcanvas);

if (sprite_exists(reference_sprite)) {
	sprite_delete(reference_sprite)
}

var i=0;
repeat(array_length(regions)) {
	var region = regions[i];
	region.cleanup();
	delete region;
	i++;
}