extends Control

onready var label = $Label
func _process(delta):
	label.text = "HP = " + str(PlayerStats.health)
