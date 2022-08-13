extends Control

onready var label = $Label
func _process(_delta):
	label.text = "HP:" + str(PlayerStats.health) + " S1:" + str(PlayerStats.get_bullet_count("slot1")) + " S2:" + str(PlayerStats.get_bullet_count("slot2")) + " S3:" + str(PlayerStats.get_bullet_count("slot3")) + " S4:" + str(PlayerStats.get_bullet_count("slot4")) + " S5:" + str(PlayerStats.get_bullet_count("slot5")) + " S6:" + str(PlayerStats.get_bullet_count("slot6"))
