// Inherit the parent event
with(mylog) {
	draw_sprite_ext(sprite_index,image_index,floor(x),floor(y)-1*(ysc<0),xsc,image_yscale*ysc,rot,image_blend,image_alpha)
}

event_inherited();