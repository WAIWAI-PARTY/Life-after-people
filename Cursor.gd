extends Node2D
onready var aim_crosshair = $Crosshair

func _process(_delta):
	aim_crosshair.global_position = get_global_mouse_position();
