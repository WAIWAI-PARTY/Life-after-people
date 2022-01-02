extends AnimatedSprite
func _ready():
# warning-ignore:return_value_discarded
	connect("animation_finished", self, "queue_free")
	play("anim")
