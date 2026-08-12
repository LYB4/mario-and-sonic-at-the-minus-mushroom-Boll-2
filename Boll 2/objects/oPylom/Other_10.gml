if (turning) {
	sprite_index = spr_pylom_turn;
} else if (stun) {
	log_yoff = 4;
	sprite_index = spr_pylom_forceshoot;
	if image_index>=image_number-1 {
		image_index=image_number-1;
	}
} else if (shooting) {
	sprite_index = spr_pylom_shoot;
	if image_index>=image_number-1 {
		image_index=image_number-1;
	}
} else if (regenerating) {
	sprite_index = spr_pylom_regen;
} else {
	sprite_index = spr_pylom_walk;
}