extends Area2D

onready var laser = preload("res://interactiveItems/laserShooter/Laser.gd")
var cooldown = true

func _on_lasershooter_area_entered(area):
	if cooldown:
		cooldown = false
		var laserIns = laser.instance()
		laserIns.rotation_degrees = area.get_parent().rotation_degrees
		laserIns.position = global_position
		get_node("/root").call_deferred("add_child", laserIns)
		$Timer.start()

func _on_Timer_timeout():
	cooldown = true
