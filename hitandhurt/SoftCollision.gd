extends Area2D

func iscolliding():
	var areas = get_overlapping_areas()
	return areas.size()>0
func get_push_vector():
	var areas = get_overlapping_areas()
	var push_vector = Vector2.ZERO
	if iscolliding():
		var area = areas[0]
		push_vector = area.global_position.direction_to(global_position)
		push_vector = push_vector.normalized()
	return push_vector
