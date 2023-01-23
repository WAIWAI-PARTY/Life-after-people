extends Node2D


func _process(_delta):
	if Input.is_action_just_pressed("time_travel"):
		if get_tree().current_scene.name == "World":
			get_tree().change_scene("res://SavedWorld/parallelWorld.tscn")
		elif get_tree().current_scene.name == "parallelWorld":
			get_tree().change_scene("res://SavedWorld/normalWorld.tscn")

