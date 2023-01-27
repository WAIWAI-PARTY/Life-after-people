extends CanvasLayer

signal transite 
func time_transition() -> void:
		$AnimationPlayer.play("dissolve")
		yield($AnimationPlayer, "animation_finished")
		$AnimationPlayer.play_backwards("dissolve")



