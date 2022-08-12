
extends Node2D
var stats = PlayerStats
export var fireCD = 0.5
export var reloadCD = 2
export var bulletCount = 6
export var magazineVol = 2
onready var shootCount = 0
var can_fire = true
var bullet = []
var reloading = false
onready var shaketimer = $ShakeTimer
onready var cam_shake = get_node("/root/World/Camera2D/shake")
onready var cam = get_node("/root/World/Camera2D")

func _ready():
	stats.bullet_count = magazineVol - shootCount
	for i in range(bulletCount):
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
	if Input.is_action_pressed("shoot") and can_fire and not(reloading):
		can_fire = false
		for i in range(bulletCount):
			var bullet_instance = bullet[i].instance()
			bullet_instance.rotation = rotation+rand_range(-0.1,0.1)
			
			bullet_instance.global_position = $GunSprite/Position2D.global_position+Vector2(rand_range(-10,10),rand_range(-10,10))
			get_node("/root").add_child(bullet_instance)
		if !cam_shake.is_shaking:
			cam.offset = lerp(cam.offset, (Vector2.RIGHT*3).rotated(rotation), 0.5)
			shaketimer.start()
		yield(get_tree().create_timer(fireCD),"timeout")
		if shootCount == magazineVol-1:
			stats.bullet_count = 0
			yield(get_tree().create_timer(reloadCD),"timeout")
			shootCount = 0
			stats.bullet_count = magazineVol - shootCount
			
		else:
			shootCount+=1
			stats.bullet_count = magazineVol - shootCount

		can_fire = true
	if Input.is_action_just_pressed("reload"):
		reloading = true
		yield(get_tree().create_timer(reloadCD/magazineVol),"timeout")
		shootCount = 0
		stats.bullet_count = magazineVol - shootCount
		reloading = false

func _on_ShakeTimer_timeout():
	cam.offset = lerp(cam.offset,Vector2.ZERO, 0.5)
