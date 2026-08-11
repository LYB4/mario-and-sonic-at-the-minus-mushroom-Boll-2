event_inherited();
fric = 0.1;

vsp = 0;
hsp = 0;

wavey = y+8;
t = 0;

itemType="shield"

escapeItemBox.Connect( self, function(hit_p, obj) {
	hsp = 0
});