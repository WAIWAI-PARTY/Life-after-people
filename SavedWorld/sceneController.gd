extends Node2D

var travelled = false
var currentCamera
func _process(_delta):
	if Input.is_action_just_pressed("time_travel"):
		if not travelled:
			travelled = true
			TimeTravelTransition.time_transition(2000)
		else:
			TimeTravelTransition.time_transition(-2000)
			travelled = false







