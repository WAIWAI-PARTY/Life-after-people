extends Control

onready var label = $Label
func _process(_delta):
	label.text =  "HP:" + str(PlayerStats.health)
