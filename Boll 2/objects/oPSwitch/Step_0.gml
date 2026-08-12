if !(is_array(pathing) && array_length(pathing)) {
	if (going!=0) {
		image_index=0
		y+=0.33*(going)
		if instance_exists(parentblock) {
			x+=parentblock.x_diff
			y+=parentblock.y_diff
			depth=oGameManager.piping_object_depth[myregion]
			if !collision_rectangle(x-hit_sizex,y-hit_sizey,x+hit_sizex,y+hit_sizey,parentblock,false,false) {
				going=0
				depth=2;
			}
		}
	} else {
		if (physics_enabled) {
			if !grounded { 
				vsp=min(vsp+grav,6);
			}

			x += hsp
			y += vsp
	
			player_collision(true, false, (bbox_left-x),bbox_right-x,(bbox_top-y)+1,(bbox_bottom-y)-1);
		}
	}
}
