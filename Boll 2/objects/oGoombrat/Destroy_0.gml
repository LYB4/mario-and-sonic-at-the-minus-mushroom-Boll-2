switch (killtype) {
	case "spinjump":
		instance_create_depth(x,y,depth,pSmoke);
	break;
	case "stomp": instance_create_depth(x,y+4,0,pStompedEnemy,{sprite_index : spr_goombratstomped}) break;
	default: instance_create_depth(x,y,0,pSpinningEnemy,{sprite_index : spr_goombratspin, vspeed : killvsp, hspeed : killhsp*xsc}) break;
}