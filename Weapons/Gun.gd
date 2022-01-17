
extends Node2D

export var fireCD = 0.5
var can_fire = true
var bullet = preload("res://Weapons/Bullets.tscn")
onready var shaketimer = $ShakeTimer
onready var cam_shake = get_node("/root/World/Camera2D/shake")
onready var cam = get_node("/root/World/Camera2D")
func _input(event):
	if event is InputEventMouseMotion:
		look_at(get_global_mouse_position())
		# keep rotation_degrees between 0 and 360
		rotation_degrees = fposmod(rotation_degrees, 360.0)
		if rotation_degrees > 90 && rotation_degrees < 270:
			$GunSprite.set_scale(Vector2(0.5,-0.5))
		else:
			$GunSprite.set_scale(Vector2(0.5,0.5))
			
func _process(_delta):
	if Input.is_action_pressed("shoot") and can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.rotation = rotation+rand_range(-0.07,0.07)
		bullet_instance.global_position = $GunSprite/Position2D.global_position
		get_parent().add_child(bullet_instance)
		if !cam_shake.is_shaking:
			cam.offset = lerp(cam.offset, (Vector2.RIGHT*3).rotated(rotation), 0.5)
			shaketimer.start()
		can_fire = false
		yield(get_tree().create_timer(fireCD),"timeout")
		can_fire = true


func _on_ShakeTimer_timeout():
	cam.offset = lerp(cam.offset,Vector2.ZERO, 0.5)
