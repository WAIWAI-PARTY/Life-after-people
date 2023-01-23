extends Node2D


func _process(_delta):
	if Input.is_action_just_pressed("time_travel"):
		$Camera2D.current = false
		$parallelWorld/Camera2D.current = true
		
		
