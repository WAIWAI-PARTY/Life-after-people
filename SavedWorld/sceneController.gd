extends Node2D

var travelled = false
func _process(_delta):
	if Input.is_action_just_pressed("time_travel"):
		
		if not travelled:
			TimeTravelTransition.time_transition(2000)
			travelled = true
<<<<<<< Updated upstream
=======


			$CanvasLayer/Label.text ="i am in past"
			$YSort/Player/RemoteTransform2D.remote_path = "/root/DemoLevel1/Camera2DPast"
			$Camera2DPast.position.x = $Camera2DFuture.position.x +10000+140
			$Camera2DPast.position.y = $Camera2DFuture.position.y
			TimeTravelTransition.time_transition(10000)
			$Camera2DPast.make_current()			



>>>>>>> Stashed changes
		else:
			TimeTravelTransition.time_transition(-2000)
			travelled = false
<<<<<<< Updated upstream
=======
			#$Camera2DFuture.position.x = $Camera2DPast.position.x -10000+140
			#$Camera2DFuture.position.y = $Camera2DPast.position.y
			#$Camera2DFuture.make_current()
			$CanvasLayer/Label.text ="i am in future"
			TimeTravelTransition.time_transition(-10000)
			#$YSort/Player/RemoteTransform2D.remote_path = "/root/DemoLevel1/Camera2DFuture"



>>>>>>> Stashed changes
