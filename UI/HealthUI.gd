extends Control

onready var label = $Label
onready var bulletType = " "
func _process(_delta):
	if PlayerStats.get_bulletType() == 0:
		bulletType ="normal"
	else:
			bulletType = "special"
			
	label.text = "HP:" + str(PlayerStats.health) + " slot1:" + PlayerStats.get_weapon_state("slot1") + " bulletType: " + bulletType
