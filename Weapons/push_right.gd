extends Area2D

func _on_right_area_entered(area):
	area.get_parent().position += Vector2.DOWN.rotated(get_parent().rotation)*10
