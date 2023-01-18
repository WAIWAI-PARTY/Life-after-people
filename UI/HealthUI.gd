extends Control

onready var label = $Label
onready var bulletType = " "
func _process(_delta):
	if PlayerStats.get_bulletType() == 0 && PlayerStats.get_weapon_name("slot1") == "sniper" :
		bulletType ="normal"
	else:
			bulletType = "special"
	
	if  PlayerStats.get_weapon_name("slot1") != "sniper" :
		bulletType ="normal"
	
	label.text = "HP:" + str(PlayerStats.health) + " slot1:" + PlayerStats.get_weapon_state("slot1") + " bulletType: " + bulletType
