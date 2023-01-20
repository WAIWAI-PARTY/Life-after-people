extends KinematicBody2D


onready var anim = $AnimationPlayer
onready var sprite = $Sprite

func _on_hurtbox_area_entered(_area):
	var shakeEffect = get_node("/root/World/Camera2D/shake")
	sprite.scale = Vector2(2.5,2.5)
	anim.play("anim")
	shakeEffect.shake(0.5, 30, 10)

func explosion_finished():
	queue_free()
