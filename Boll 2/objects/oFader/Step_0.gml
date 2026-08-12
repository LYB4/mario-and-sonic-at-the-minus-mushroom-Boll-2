if !(fadeout) && !(fadewaiting) {
	fade += fadespd
} else if (fadeout) {
	fade -= fadespd
}

if (fade >= fademax && !fadeout && !fadewaiting) && !(didfunction) {
	fade = fademax;
	fadewaiting = true;
	
	if !(didfunction) {
		didfunction = true;
		onTransition();
	}
}

if (fadewaiting) {
	fade = fademax;
	fadewait -= fadespd;
	if !(fadewait) {
		fadewaiting = false;
		fadeout = true;
	}
}

if (fade <= 0 && fadeout) {
	instance_destroy();	
}