switch(killtype) {
	case "spinjump":
		instance_create_depth(x,y,depth,pSmoke);
	break;
	default: instance_create_depth(x,y,0,pSpinningEnemy,{sprite_index : spr_buzzyshell_kick, vspeed : killvsp, hspeed : killhsp*xsc})
}