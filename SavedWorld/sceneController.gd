extends Node2D

var travelled = false
func _process(_delta):
	if Input.is_action_just_pressed("time_travel"):
		if not travelled:
			$YSort/Player.position.x+=2000
			travelled = true
		else:
			$YSort/Player.position.x-=2000
			travelled = false
#		if get_tree().current_scene.name == "World":
#			get_tree().change_scene("res://SavedWorld/parallelWorld.tscn")
#		elif get_tree().current_scene.name == "parallelWorld":
#			get_tree().change_scene("res://SavedWorld/normalWorld.tscn")

