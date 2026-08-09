event_inherited()
warpname="" //name of this pipe
warptarget="" //name of other pipe to warp to
warplevel="" //Level warping for stuff like warp zones.
mytargetpipe=noone;

assist = noone;
content = "nothing";
spawn_timer = 120;
spawning = spawn_timer;
stop_spawning = false;

depth = 0;

spawnObject = function() {
	var j = noone;

	switch content {
		case "piranha plant": {
			j = oPiranhaPlant;
			stop_spawning = true;
		} break;
	
		case "jumping piranha": {
			j = oJumpingPiranha;
			stop_spawning = true;
		} break;
		
		case "goomba": {
			j = oGoomba;
			spawning=spawn_timer;
		} break;
		
		case "goombrat": {
			j = oGoombrat;
			spawning=spawn_timer;
		} break;
		
		case "green koopa": {
			j = oKoopa;
			spawning=spawn_timer;
		} break;
		
		case "red koopa": {
			j = oKoopaRed;
			spawning=spawn_timer;
		} break;
		
		case "yellow koopa": {
			j = oKoopaYellow;
			spawning=spawn_timer;
		} break;
		
		case "iceskating koopa": {
			j = oKoopaSkating;
			spawning=spawn_timer;
		} break;
		
		case "buzzy beetle": {
			j = oBuzzyBeetle;
			spawning=spawn_timer;
		} break;
		
		case "chasing bumpty":
		case "wandering bumpty": {
			j = oBumpty;
			spawning=spawn_timer;
		} break;
	
		case "mushroom": {
			j = oMushroom;
		} break;
	
		default : exit;
	}

	assist = instance_create(x, y, j);
	with (assist) {
		myregion = other.myregion;
		depth = oGameManager.piping_object_depth[myregion];
		
		if (object_get_parent(object_index) == oMushroom) || (object_index == oMushroom) {
			parentblock = other;
			going = 1;
			break;
		}
		
		if (object_is_ancestor(object_index,oEnemy)) {
			piping = true;
			piping_coll = other.id;
			spawned_from_pipe = true;
			grounded = false;
			if (other.content == "wandering bumpty") {
				behavior_mode = bumptyBehaviors.wander_mode
			} else if (other.content == "chasing bumpty") {
				behavior_mode = bumptyBehaviors.jumping_mode
			}
			event_user(15);
			break;
		}
	
		parent_pipe = other;
		rot = other.image_angle;
		if (object_get_parent(object_index) != oPiranhaPlant && object_index != oPiranhaPlant && object_index != oJumpingPiranha) {
			other.assist = noone;
			break;
		}
		
		if (object_index == oJumpingPiranha) {
			dojump=true;
		}
	}
}