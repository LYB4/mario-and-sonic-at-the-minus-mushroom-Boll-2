if (shot) {
	switch(face_dir) {
		case 0:
			sprite_index = spr_firepiranhashootmiddle;
		break;
		case 1:
			sprite_index = spr_firepiranhashootdown;
		break;
		case -1:
			sprite_index = spr_firepiranhashootup;
		break;
	}
} else {
	switch(face_dir) {
		case 0:
			sprite_index = spr_firepiranhaidlemiddle;
		break;
		case 1:
			sprite_index = spr_firepiranhaidledown;
		break;
		case -1:
			sprite_index = spr_firepiranhaidleup;
		break;
	}
}