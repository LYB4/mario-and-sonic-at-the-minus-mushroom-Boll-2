enum footstepMaterial {
	Default,
	Grass,
	Stone,
	Snow,
	Wood,
	Plastic,
	Metal,
	Ice,
}

#macro FOOTSTEP_GAIN 0.5

global.footsteps = [];
global.footsteps[footstepMaterial.Default] = {
	walk_r: footstep_walk_r,
	walk_l: footstep_walk_l,
	run_r:  footstep_run_r,
	run_l:  footstep_run_l,
	jump:   -1,
	land:   -1
};
global.footsteps[footstepMaterial.Grass] = {
	walk_r: footstep_grass_walk_r,
	walk_l: footstep_grass_walk_l,
	run_r:  footstep_grass_run_r,
	run_l:  footstep_grass_run_l,
	jump:   -1,
	land:   -1
};
global.footsteps[footstepMaterial.Stone] = {
	walk_r: footstep_stone_walk_r,
	walk_l: footstep_stone_walk_l,
	run_r:  footstep_stone_run_r,
	run_l:  footstep_stone_run_l,
	jump:   -1,
	land:   -1
};
global.footsteps[footstepMaterial.Snow] = {
	walk_r: footstep_snow_walk_r,
	walk_l: footstep_snow_walk_l,
	run_r:  footstep_snow_run_r,
	run_l:  footstep_snow_run_l,
	jump:   footstep_snow_jump,
	land:   footstep_snow_land
};
global.footsteps[footstepMaterial.Wood] = {
	walk_r: footstep_wood_walk_r,
	walk_l: footstep_wood_walk_l,
	run_r:  footstep_wood_run_r,
	run_l:  footstep_wood_run_l,
	jump:   -1,
	land:   -1
};
global.footsteps[footstepMaterial.Metal] = {
	walk_r: footstep_metal_walk_r,
	walk_l: footstep_metal_walk_l,
	run_r:  footstep_metal_run_r,
	run_l:  footstep_metal_run_l,
	jump:   -1,
	land:   -1
};
global.footsteps[footstepMaterial.Ice] = {
	walk_r: footstep_ice_walk_r,
	walk_l: footstep_ice_walk_l,
	run_r:  footstep_ice_run_r,
	run_l:  footstep_ice_run_l,
	jump:   -1,
	land:   -1
};


function play_footstep() {
	if !(footstep_freq) exit;
	
	if (round(frame) mod footstep_freq == 0) && (round(frame)!=0) && !(footstep_played) {
		var variance = random_range(0.8,1.1);
		if !(footstep_run) {
			if !(footstep_foot) {
				VinylPlay(global.footsteps[footstep_material][$ "walk_l"],0,FOOTSTEP_GAIN,variance);
			} else {
				VinylPlay(global.footsteps[footstep_material][$ "walk_r"],0,FOOTSTEP_GAIN,variance);
			}
		} else {
			if !(footstep_foot) {
				VinylPlay(global.footsteps[footstep_material][$ "run_l"],0,FOOTSTEP_GAIN,variance);
			} else {
				VinylPlay(global.footsteps[footstep_material][$ "run_r"],0,FOOTSTEP_GAIN,variance);
			}
		}
		footstep_played = true;
		footstep_foot = !footstep_foot;
	}
}

function play_footstep_land() {
	if (global.footsteps[footstep_material].land == -1) {
		if !(footstep_run) {
			if !(footstep_foot) {
				VinylPlay(global.footsteps[footstep_material][$ "walk_l"],0,FOOTSTEP_GAIN);
			} else {
				VinylPlay(global.footsteps[footstep_material][$ "walk_r"],0,FOOTSTEP_GAIN);
			}
		} else {
			if !(footstep_foot) {
				VinylPlay(global.footsteps[footstep_material][$ "run_l"],0,FOOTSTEP_GAIN);
			} else {
				VinylPlay(global.footsteps[footstep_material][$ "run_r"],0,FOOTSTEP_GAIN);
			}
		}
	} else {
		VinylPlay(global.footsteps[footstep_material][$ "land"],0,FOOTSTEP_GAIN);
	}
	
	footstep_foot = !footstep_foot;
}

function play_footstep_jump() {
	if (global.footsteps[footstep_material].jump != -1) {
		VinylPlay(global.footsteps[footstep_material][$ "jump"],0,FOOTSTEP_GAIN);
	}
}

function sample_footstep_material() {
	var coll = check_collision_line_obj(x-hit_sizex, y+hit_sizey+1, x+hit_sizey, y+hit_sizey+1, COL_BOTTOM);
	if (coll) {
		if (variable_instance_exists(coll,"footstep_material")) {
			footstep_material = coll.footstep_material;
		}
	}
}