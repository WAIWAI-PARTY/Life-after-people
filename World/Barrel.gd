extends KinematicBody2D
onready var anim = $AnimationPlayer
func _on_hurtbox_area_entered(_area):
	anim.play("anim")


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
