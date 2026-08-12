if (turning) {
	sprite_index = spr_pylom_turn;
} else if (stun) {
	sprite_index = spr_pylom_forceshoot;
	if image_index>=image_number-1 {
		image_index=image_number-1;
	}
} else {
	sprite_index = spr_pylom_walk;
}