if !(is_array(pathing) && array_length(pathing)) {
	if (going!=0) {
		vsp=3*going;
		going=0;
	}
	
	if (vsp!=0) {
		vsp = approach_val(vsp,0,fric);

		y += vsp;
		
		if (vsp == 0) {
			wavey = y;
		}
	} else {
		y = wave_val(wavey-4,wavey+4,1,0,t);
		t+=1;
	}
} else {
	node_path_movement();
}

if collision_rectangle(x-hit_sizex,y-hit_sizey,x+hit_sizex,y+hit_sizey,oDeactivationRegion,false,false) && !on_screen(sprite_width,sprite_height) {
	instance_destroy();
}