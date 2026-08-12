// Inherit the parent event
event_inherited();

hit_sizey=16;
goto_yscale = image_yscale;
parent = noone;

enemyStomped.Destroy();

enemySpinjumped.Destroy();

enemyShelled.Destroy();

enemyPounded.Destroy();

enemyPounded.Connect( self, function(hit_p) {
	if (goto_yscale < 0.5) exit;
	
	with(hit_p) {
		increase_combo(other.x,y+hit_sizey+6,snd_enemystomp);
	}
	with(parent) {
		forceShoot.Emit();
	}
	hp=1;
});

enemyStomped.Connect( self, function(hit_p) {
	if (goto_yscale < 0.5) exit;
	
	if !(hit_p.spinjump) {
		with(hit_p) {
			increase_combo(other.x,y+hit_sizey+6,snd_enemystomp);
			
			sig.Emit("enemy_stomped")
			instance_create_depth(x,y+hit_sizey,-5,pImpact)
		}
		phaseid=hit_p;
		phase_leeway=7;
		with(parent) {
			forceShoot.Emit();
		}
	} else {
		with(hit_p) {
			instance_create_depth(x,y+hit_sizey,-5,pImpact)
			sig.Emit("enemy_spinjumped");
		}
		VinylPlay(snd_enemyspinjump_reflect)
		phaseid=hit_p;
		phase_leeway=7;
	}
	hp=1;
});
