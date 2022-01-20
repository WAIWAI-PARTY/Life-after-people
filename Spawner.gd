extends Node2D

var Enemy = preload("res://Enemy/Slime.tscn")

func _on_SpawnTimer_timeout():
	var enemy = Enemy.instance()
	get_node("/root/World/YSort/slimes").add_child(enemy)
	enemy.position = $Spawn.position
