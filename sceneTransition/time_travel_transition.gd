extends CanvasLayer

signal transite
var travel_distance = 0
func time_transition(value) -> void:
	travel_distance = value
	$AnimationPlayer.play("dissolve")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "dissolve":
		get_node("/root/DemoLevel1/FutureWorld").position.x += travel_distance
		get_node("/root/DemoLevel1/PastWorld").position.x -= travel_distance
		$AnimationPlayer.play("dissolve_back")
