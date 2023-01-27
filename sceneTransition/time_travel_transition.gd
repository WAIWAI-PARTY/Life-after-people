extends CanvasLayer

signal transite
var travel_distance = 0
func time_transition(value) -> void:
	travel_distance = value
	$AnimationPlayer.play("dissolve")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "dissolve":
		get_tree().get_nodes_in_group("player")[0].position.x += travel_distance
		$AnimationPlayer.play("dissolve_back")
