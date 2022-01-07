extends KinematicBody2D

onready var anim = $AnimationPlayer
onready var sprite = $Sprite

func _on_hurtbox_area_entered(_area):
	sprite.scale = Vector2(4,4)
	anim.play("anim")
func explosion_finished():
	queue_free()
