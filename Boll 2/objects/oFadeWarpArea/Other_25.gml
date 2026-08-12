instance_activate_object(oPipe)
with(oPipe) {
	if (warpname == other.warptarget) {
		other.mytargetpipe = id;
		exit;
	}
}
instance_activate_object(oWarpDestination)
with(oWarpDestination) {
	if (warpname == other.warptarget) {
		other.mytargetpipe = id;
		break;
	}
}