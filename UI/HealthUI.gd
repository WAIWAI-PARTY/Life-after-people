extends Control

onready var label = $Label
func _process(_delta):
	label.text = "Not REALITY! NOT! HP:" + str(PlayerStats.health)
