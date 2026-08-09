if instance_exists(oPlayer) {
	var i=0;
	repeat(array_length(hidden_tile_layers[oPlayer.myregion])) {
		var _layer = hidden_tile_layers[oPlayer.myregion][i]
		_layer.touched=false;
		i++;
	}
}