///@description Empty Contents on bump
event_inherited();
//extra coins
var i=instance_create_depth(x-16,y,0,pCoinCollected)
i.vspeed=3*hit
i.gravity=0.15*-sign(i.vspeed)
var i=instance_create_depth(x+16,y,0,pCoinCollected)
i.vspeed=3*hit
i.gravity=0.15*-sign(i.vspeed)
var playsound = bool(content!="coin" && content!="multicoins")  //prevent sound overlap
collect_coins(2,playsound);