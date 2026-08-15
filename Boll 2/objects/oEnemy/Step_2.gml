if (hp <= 0) {
	enemyKilled.Emit();
    instance_destroy();
}

if (phaseid) && !check_hitbox_on_hitbox(id,phaseid) && !(grabbed) {
	phase_leeway=max(phase_leeway-1,0)
	if !phase_leeway {
		phaseid=noone
	}
}