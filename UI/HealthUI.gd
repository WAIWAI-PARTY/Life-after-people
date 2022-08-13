extends Control

onready var label = $Label
func _process(_delta):
	label.text = "HP:" + str(PlayerStats.health) + " S1:" + PlayerStats.get_weapon_state("slot1") + " S2:" + PlayerStats.get_weapon_state("slot2") + " S3:" + PlayerStats.get_weapon_state("slot3") + " S4:" + PlayerStats.get_weapon_state("slot4") + " S5:" + PlayerStats.get_weapon_state("slot5") + " S6:" + PlayerStats.get_weapon_state("slot6")
