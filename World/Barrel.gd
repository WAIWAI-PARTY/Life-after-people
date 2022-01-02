extends KinematicBody2D
var explosion = preload("res://Effect/Explosion_Effect.tscn")

func _on_hurtbox_area_entered(area):
	var edf = explosion.instance()
	get_parent().add_child(edf)
	edf.global_position = global_position
	queue_free()
