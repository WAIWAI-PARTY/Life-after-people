extends Node2D

var travelled = false
func _process(_delta):
	if Input.is_action_just_pressed("time_travel"):
		if not travelled:
			$YSort/Player.position.x+=2000
			travelled = true
		else:
			$YSort/Player.position.x-=2000
			travelled = false
