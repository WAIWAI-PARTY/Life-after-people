extends Node2D
onready var aim_crosshair = $Crosshair
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)




func _process(delta):
	aim_crosshair.global_position = get_global_mouse_position();
