extends Area2D



#	pass


func _on_stage1_body_entered(body):
	$"../../Camera2DFuture".limit_left = -60
	$"../Futureprop/Player".z_index = 3

func _on_stage1_body_exited(body):
	$"../../Camera2DFuture".limit_left = -250
	$"../Futureprop/Player".z_index = 0
