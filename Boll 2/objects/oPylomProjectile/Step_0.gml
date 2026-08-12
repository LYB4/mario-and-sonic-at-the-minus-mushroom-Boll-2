x+=hsp;
y+=vsp;

image_xscale=esign(-hsp,1)

if check_collision_rectangle(x-hit_sizex,y-hit_sizey,x+hit_sizex,y+hit_sizey,COL_WALL) || collision_rectangle(x-hit_sizex,y-hit_sizey,x+hit_sizex,y+hit_sizey,oDeactivationRegion,false,false) || !on_screen(32,32) {
	instance_destroy();
}