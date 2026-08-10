// Inherit the parent event

var p=nearestplayer();

event_inherited();

if !(shot) {
	if (rot mod 180 == 0) {
		var mult = 1;
		if (rot == 180) mult = -1;
		
		if (p.y < y-12) {
		    face_dir = -1*mult;
		} else if (p.y > y+10) {
		    face_dir = 1*mult;
		} else {
		    face_dir = 0;
		}

		xsc = -esign(p.x-x,1)*mult;
	} else {
		var mult = 1;
		if (rot == 270) mult = -1;
		
		if (p.x < x-12) {
		    face_dir = -1*mult;
		} else if (p.x > x+10) {
		    face_dir = 1*mult;
		} else {
		    face_dir = 0;
		}

		xsc = esign(p.y-y,1)*mult;
	}
}