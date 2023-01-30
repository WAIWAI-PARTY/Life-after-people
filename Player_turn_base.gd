extends Node2D


var turn = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(delta):
	if turn > 0 and not $Tween.is_active():
		if Input.is_action_just_pressed("ui_up"):
			$Tween.interpolate_property(self, "global_position:y", global_position.y, global_position.y-64, 0.1, 9, 2)
		if Input.is_action_just_pressed("ui_down"):
			$Tween.interpolate_property(self, "global_position:y", global_position.y, global_position.y+64, 0.1, 9, 2)
		if Input.is_action_just_pressed("ui_left"):
			$Tween.interpolate_property(self, "global_position:x", global_position.x, global_position.x-64, 0.1, 9, 2)
		if Input.is_action_just_pressed("ui_right"):
			$Tween.interpolate_property(self, "global_position:x", global_position.x, global_position.x+64, 0.1, 9, 2)
		$Tween.start()
		print(position)
