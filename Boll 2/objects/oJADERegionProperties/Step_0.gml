if (window_has_focus()) {
	x=median(x,0,oJADEController.guiw-sprite_width)
	y=median(y,0,oJADEController.guih-sprite_height)
}

mbleftpress = mouse_check_button_pressed(mb_left)

if (mbleftpress) && !instance_exists(oJADEDropDown) {
	exitbutton.update();
	newregionbutton.update();
	
	
	var curs_x = window_mouse_get_x()
	var curs_y = window_mouse_get_y()
	if (point_in_rectangle(curs_x,curs_y,x,y+18,x+96,y+195)) {
		var i=0;
		var regionlist = oJADEController.regions;
		var len = array_length(regionlist);
		repeat(len) {
			var guix = x;
			var guiy = y-scroll_y+20+18*i
			if point_in_rectangle(curs_x,curs_y,guix,guiy,guix+94,guiy+16) {
				oJADEController.selected_region = i;
				with(oJADEController) {
					update_region();
				}
				break;
			}
			i++;
		}
	}
}