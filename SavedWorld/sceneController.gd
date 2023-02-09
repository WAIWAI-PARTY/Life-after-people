extends Node2D

var travelled = false
var currentCamera
func _process(_delta):
	if Input.is_action_just_pressed("time_travel"):
		if not travelled:
			travelled = true
			$CanvasLayer/Label.text ="i am in past"
			TimeTravelTransition.time_transition(10000)
		else:
			travelled = false
			$CanvasLayer/Label.text ="i am in future"
			TimeTravelTransition.time_transition(-10000)


