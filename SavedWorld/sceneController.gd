extends Node2D


func _process(_delta):
	if Input.is_action_just_pressed("time_travel"):
		get_tree().change_scene("res://SavedWorld/parallelWorld.tscn")

