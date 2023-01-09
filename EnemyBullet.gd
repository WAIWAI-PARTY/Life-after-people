extends KinematicBody2D

const speed = 200

func _process(delta):
	move_and_slide((Vector2.RIGHT*speed).rotated(rotation))

func _on_KillTimer_timeout():
	queue_free()

func _on_hitbox_area_entered(_area):
	queue_free()
