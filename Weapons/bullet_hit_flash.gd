extends AnimatedSprite

func _ready():
	play("default")
func _on_bullet_hit_flash_animation_finished():
	queue_free()
