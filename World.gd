extends Node

var Enemy = preload("res://Enemy/Slime.tscn")


func _on_SpawnTimer_timeout():
	var enemy = Enemy.instance()
	get_node("YSort/slimes").add_child(enemy)
	enemy.position = $Spawn.position
