extends Node

var Enemy = preload("res://Enemy/Slime.tscn")

func _process(delta):
	if Input.is_action_pressed("bullet_time"):
		Engine.time_scale = 0.2
	elif Input.is_action_just_released("bullet_time"):
		Engine.time_scale = 1

func _on_SpawnTimer_timeout():
	var enemy = Enemy.instance()
	get_node("YSort/slimes").add_child(enemy)
	enemy.position = $Spawn.position
