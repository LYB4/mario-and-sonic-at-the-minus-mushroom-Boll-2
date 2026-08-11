// Inherit the parent event
switch(killtype) {
	case "spinjump":
		instance_create_depth(x,y,depth,pSmoke);
	break;
	default: instance_create_depth(x,y,0,pSpinningEnemy,{sprite_index : spr_polarbeardead, vspeed : -1, hspeed : 0})
}

if instance_exists(myBalloon) {
	myBalloon._owner=noone;
		with(myBalloon) {
		hsp=-other.constantspd;
	}
}