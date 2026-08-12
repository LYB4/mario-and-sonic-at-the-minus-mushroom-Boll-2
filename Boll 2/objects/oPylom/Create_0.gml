// Inherit the parent event
event_inherited();

maxammo = 2;
ammo = maxammo;
stun = 0;
shoottimer = 0;
shootwindup = -1;
shooting = false;
regenerating = false;
regentimer = 0;
shootingcooldown = 0;

mylog = instance_create_depth(x,y,depth+1,oPylomLog);
mylog.parent = id;

log_yoff = 0;

shoot = new Signal();
forceShoot = new Signal();
regenerate = new Signal();
onStunRecover = new Signal();

shoot.Connect( self, function() {
	ammo = max(ammo-1,0);
	with(mylog) {
		goto_yscale=0.5*other.ammo;
		hit_sizey = goto_yscale*16;
	}
	
	var i = instance_create_depth(x-4*xsc,y+2,0,oPylomProjectile)
	i.hsp = 2*-xsc;
});

forceShoot.Connect( self, function() {
	stun = 60;
	constantspd = 0;
	regenerating = false;
	regentimer = 0;
	log_yoff = 4;
	sprite_index = spr_pylom_forceshoot;
	image_index = 0;
	
	shoot.Emit();
});

regenerate.Connect( self, function() {
	regenerating = true;
	constantspd = 0;
	sprite_index = spr_pylom_regen;
	
	ammo = min(ammo+1,maxammo);
	with(mylog) {
		goto_yscale=0.5*other.ammo;
		hit_sizey = goto_yscale*16;
	}
});

onStunRecover.Connect( self, function() {
	log_yoff = 0;
	shooting = false;
	if (ammo==maxammo) {
		constantspd = 0.5;
	} else {
		regenerate.Emit();
		regentimer = 30;
	}
});

enemySpinjumped.Destroy();

enemySpinjumped.Connect( self, function(hit_p) {
	with(hit_p) {
		instance_create_depth(x,y+hit_sizey,-5,pImpact)
		sig.Emit("enemy_spinjumped");
	}
	VinylPlay(snd_enemyspinjump_reflect)
	phaseid=hit_p;
	phase_leeway=7;
});