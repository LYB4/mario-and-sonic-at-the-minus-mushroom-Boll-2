image_xscale=1;
image_yscale=1;
myregion = 0;

if room==rGame {
	var inst = instance_create_depth(x+8,y,0,oPlayer)
	inst.myregion = myregion;
	with(oGameManager) {
		switch_region(other.myregion);
	}
} else {
	var inst = instance_create_depth(x+8,y,0,oWMPlayer)
	inst.myregion = myregion;
	with(oGameManager) {
		switch_region(other.myregion);
	}
}

instance_destroy();

if (!instance_exists(oTouchControl) && global.touchscreen=1) instance_create(x,y,oTouchControl)