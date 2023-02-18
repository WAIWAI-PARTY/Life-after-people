extends Area2D



#	pass


func _on_stage1_body_entered(body):
	$"../../Camera2DFuture".limit_left = -60
	$"../../Camera2DFuture".limit_top = 359
	$"../../Camera2DFuture".limit_right = 620
	$"../../Camera2DFuture".limit_bottom = 709
func _on_stage1_body_exited(body):
	$"../../Camera2DFuture".limit_left = -250
	$"../../Camera2DFuture".limit_top = -100
	$"../../Camera2DFuture".limit_right = 362
	$"../../Camera2DFuture".limit_bottom = 348
