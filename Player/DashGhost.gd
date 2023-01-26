extends Sprite
var gay_mode = false
func _ready():
	set("modulate:s", 50)
	$Tween.interpolate_property(self, "modulate:a", 1.0, 0.0 , 2, 3 ,1)
	if gay_mode:
		$Tween.interpolate_property(self, "modulate:s", 1.0, 0.0 , 2, 3 ,1)
		$Tween.interpolate_property(self, "modulate:h", 1.0, 0.0 , 2, 3 ,1)
	$Tween.start()
func _on_Tween_tween_completed(_object, _key):
	queue_free()
