extends Node2D

var travelled = false
func _process(_delta):
	if Input.is_action_just_pressed("time_travel"):
		if not travelled:
			TimeTravelTransition.time_transition(2000)
			travelled = true
		else:
			TimeTravelTransition.time_transition(-2000)
			travelled = false
