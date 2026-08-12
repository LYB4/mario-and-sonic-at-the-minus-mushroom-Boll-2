// Inherit the parent event
event_inherited();

maxammo = 2;
ammo = maxammo;
stun = 0;

mylog = instance_create_depth(x,y,depth+1,oPylomLog);
mylog.parent = id;

shoot = new Signal();
forceShoot = new Signal();
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
	sprite_index = spr_pylom_forceshoot;
	image_index = 0;
	
	shoot.Emit();
});

onStunRecover.Connect( self, function() {
	constantspd = 0.5;
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