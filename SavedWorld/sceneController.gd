extends Node2D


var travelled = false
var currentCamera
func _process(_delta):
	if Input.is_action_just_pressed("time_travel"):
		if not travelled:
			travelled = true
			#movePlayerParent(travelled)
			#$Camera2DFuture.limit_left = -100000
			$CanvasLayer/Label.text ="i am in past"
			#TimeTravelTransition.time_transition(10000)
			#$Camera2DFuture.limit_left = -140+10000
		else:
			travelled = false
			#$Camera2DFuture.limit_left = 100000
			$CanvasLayer/Label.text ="i am in future"
			TimeTravelTransition.time_transition(-10000)
			#$Camera2DFuture.limit_left = -140

func movePlayerParent(travelled):
	if travelled == true:
		var player_node = get_tree().get_nodes_in_group("player")
		player_node.get_parent().remove_child(player_node)
		get_node("PastWorld/Pastprop").add_child(player_node)
	
