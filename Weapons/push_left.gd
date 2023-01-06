extends Area2D

func _on_left_area_entered(area):
	area.get_parent().position += Vector2.UP.rotated(get_parent().rotation)*10
