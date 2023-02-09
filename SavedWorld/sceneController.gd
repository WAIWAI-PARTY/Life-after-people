extends Node2D

var travelled = false
var currentCamera
func _process(_delta):
	if Input.is_action_just_pressed("time_travel"):
		if not travelled:
			travelled = true
			#$Camera2DFuture.limit_left = -100000
			$CanvasLayer/Label.text ="i am in past"
			TimeTravelTransition.time_transition(10000)
			#$Camera2DFuture.limit_left = -140+10000
		else:
			travelled = false
			#$Camera2DFuture.limit_left = 100000
			$CanvasLayer/Label.text ="i am in future"
			TimeTravelTransition.time_transition(-10000)
			#$Camera2DFuture.limit_left = -140

