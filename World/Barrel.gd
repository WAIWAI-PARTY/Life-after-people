extends KinematicBody2D
onready var anim = $AnimationPlayer
func _on_hurtbox_area_entered(_area):
	anim.play("anim")
func explosion_finished():
	queue_free()
