instance_create_depth(x,y,0,pSpinningEnemy,{sprite_index : spr_pylom_death, vspeed : killvsp, hspeed : killhsp*xsc})
if (instance_exists(mylog)) {
	instance_destroy(mylog);
}