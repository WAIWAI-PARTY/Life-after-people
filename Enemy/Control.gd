extends Control

onready var label = $Label
onready var stats = $"../Stats"
func _process(delta):
	label.text = "HP = " + str(stats.health)
