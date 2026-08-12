warptarget = "";
mytargetpipe = noone;

doWarp = function() {
	with(oPlayer) {
		warp_coll=other.id;
	}
	FadeTransition(0.25,function() {
		with(oPlayer) {
			warp_transition();
		}
	})
}