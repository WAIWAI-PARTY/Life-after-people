extends AnimatedSprite
func _ready():
	connect("animation_finished", self, "queue_free")
	play("anim")
