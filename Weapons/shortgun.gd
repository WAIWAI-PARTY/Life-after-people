
extends Node2D

export var fireCD = 0.5
var can_fire = true
var bullet = []
onready var shaketimer = $ShakeTimer
onready var cam_shake = get_node("/root/World/Camera2D/shake")
onready var cam = get_node("/root/World/Camera2D")
func _ready():
	for i in range(9):
		bullet.append(preload("res://Weapons/Bullets.tscn"))
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
		for i in range(9):
			var bullet_instance = bullet[i].instance()
			bullet_instance.rotation = rotation+rand_range(-0.1,0.1)
			bullet_instance.global_position = $GunSprite/Position2D.global_position
			get_parent().add_child(bullet_instance)
		if !cam_shake.is_shaking:
			cam.offset = lerp(cam.offset, (Vector2.RIGHT*5).rotated(rotation), 0.5)
			shaketimer.start()
		can_fire = false
		yield(get_tree().create_timer(fireCD),"timeout")
		can_fire = true


func _on_ShakeTimer_timeout():
	cam.offset = lerp(cam.offset,Vector2.ZERO, 0.5)
