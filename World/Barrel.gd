extends KinematicBody2D
var explosion = preload("res://Effect/Explosion_Effect.tscn")
onready var hitbox = $hitbox
func _on_hurtbox_area_entered(_area):
	hitbox.scale = Vector2(1,1)
	var edf = explosion.instance()
	get_parent().add_child(edf)
	edf.scale*=2.5
	edf.global_position = global_position
	yield(get_tree().create_timer(0.1), "timeout")
	queue_free()
