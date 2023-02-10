extends Area2D



#	pass


func _on_stage1_body_entered(body):
	$"../../Camera2DFuture".limit_left = 7


func _on_stage1_body_exited(body):
	$"../../Camera2DFuture".limit_left = -140
