// Inherit the parent event
event_inherited();

shootingcooldown = max(shootingcooldown-1, 0);
shoottimer = max(shoottimer-1, 0);

var pl=nearestplayer()

if (pl) && !(stun) && (within(pl.x,x+min(128*-xsc,0),x+max(128*-xsc,0))) && (within(pl.y,y-64,y+64)) && !(regenerating) && !(shootingcooldown) {
	if !(shooting) && (ammo) {
		shooting = true;
		shoottimer = 0;
		shootwindup = 15;
		image_index = 0;
		constantspd = 0;
		var olddir = _direction;
		var newdir = esign(pl.x-x,-xsc);
		if (olddir != newdir) {
			enemyTurnAround.Emit();
			xsc=-_direction;
		}
	}
	
	if (shootwindup) { //for lining up the shoot animation
		shootwindup = max(shootwindup-1, 0);
	}
	
	if !(shoottimer) && !(shootwindup) {
		if (ammo) {
			shoot.Emit();
		
			shoottimer = 60;
			shootwindup = 40;
		} else {
			shooting = false;
			regenerate.Emit();
			regentimer = 30;
		}
	}
	
	if (shootwindup == 0) && (ammo) {
		image_index = 0;
		shootwindup = -1;
	}
} else if (shooting) && !(stun) && !(shoottimer) {
	shooting = false;
	shootingcooldown = 120;
	if (ammo == maxammo) {
		constantspd = 0.5;
	} else {
		regenerate.Emit();
		regentimer = 30;
	}
}

if (regenerating) {
	regentimer = max(regentimer-1,0);
	
	if !(regentimer) {
		if (ammo!=maxammo) {
			regenerate.Emit();
			
			regentimer = 30;
		} else {
			regenerating = false;
			constantspd = 0.5;
			shootingcooldown = 120;
		}
	}
}

if (stun) {
	stun=max(stun-1,0);

	if !(stun) {
		onStunRecover.Emit();
	}
}

if (instance_exists(mylog)) {
	mylog.x = x;
	mylog.y = y-(mylog.sprite_height/2)-8+log_yoff;
	mylog.xsc = xsc;
}