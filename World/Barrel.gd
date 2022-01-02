extends KinematicBody2D
var explosion = preload("res://Effect/Explosion_Effect.tscn")
onready var hitbox = $hitbox/CollisionShape2D
func _on_hurtbox_area_entered(_area):
	var edf = explosion.instance()
	get_parent().add_child(edf)
	edf.scale*=2.5
	edf.global_position = global_position
