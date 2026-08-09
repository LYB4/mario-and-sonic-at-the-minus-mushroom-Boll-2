global.roomTarget = -1;
global.midTransition = false;

//Called whenever you want to go from one room to another, using any combination of in/out sequences
function TransitionStart(_roomTarget, _typeOut, _typeIn)
{
	if (!global.midTransition)
	{
		global.midTransition = true;
		global.roomTarget = _roomTarget;
		TransitionPlaceSequence(_typeOut);
		if (is_handle(_typeIn)) {
			layer_set_target_room(_roomTarget)
			TransitionPlaceSequence(_typeIn);
			layer_reset_target_room();
		}
		return true;
	}
	else return false
}

function sequence_transition_draw()
{
	if surface_exists(oGameManager.gameoversurface) {
		surface_set_target(oGameManager.gameoversurface);
	}
}

function sequence_transition_draw_stop()
{
	surface_reset_target();
}

//Places the sequences in the room
function TransitionPlaceSequence(_type)
{
	if (layer_exists("transition")) layer_destroy("transition")
	var _lay = layer_create(0,"transition")
	layer_script_begin(_lay, sequence_transition_draw);
	layer_script_end(_lay, sequence_transition_draw_stop);
	layer_sequence_create(_lay,RESOLUTION_X/2,RESOLUTION_Y/2,sq_gameover);
}

//Called as a moment at the end of an "Out" transition sequence
function TransitionChangeRoom()
{
	room_goto(global.roomTarget);
	TransitionFinished();
}

//Called as a moment at the end of an "In" transition sequence
function TransitionFinished()
{
	layer_sequence_destroy(self.elementID);
	global.midTransition = false;
}

function FadeTransition(SpdInSecs,func) {
	var i = instance_create_depth(0,0,0,oFader)
	with (i) {
		fademax = (60*SpdInSecs);
		onTransition = func;
	}
}