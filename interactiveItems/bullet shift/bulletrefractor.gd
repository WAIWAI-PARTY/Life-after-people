extends Area2D

func _on_bulletrefractor_area_entered(area):
	area.get_parent().rotation_degrees = rand_range(0, 359)
