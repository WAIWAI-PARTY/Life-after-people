extends Area2D

func _on_right_area_entered(area):
	area.get_parent().velocity = global_position.direction_to($"../right2".global_position)*25000*get_process_delta_time()
