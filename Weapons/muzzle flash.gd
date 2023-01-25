extends AnimatedSprite

func _on_muzzle_flash_animation_finished():
	queue_free()
