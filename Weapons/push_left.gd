extends Area2D

func _on_left_area_entered(area):
	area.get_parent().velocity = global_position.direction_to($"../left2".global_position)*50000*get_process_delta_time()
