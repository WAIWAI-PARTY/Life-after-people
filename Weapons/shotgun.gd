
extends Node2D
var stats = PlayerStats
export var weapon_name = "shotgun"
export var fireCD = 0.5
export var reloadCD = 1.5
export var bulletCount = 6
export var magazineVol = 2
export var readyCD = 0.7
onready var shootCount = 0
var can_fire = false
var bullet = []
var notReloading = true
onready var shaketimer = $ShakeTimer
onready var cam_shake = get_node("/root/World/Camera2D/shake")
onready var cam = get_node("/root/World/Camera2D")

func _ready():
	stats.playerStats["current_weapon"] = weapon_name
	followMouse()
	shootCount = stats.get_bullet_count(get_parent().name)
	if shootCount >= magazineVol:
		checkReload()
	else:
		$readyTimer.start(readyCD)
	for i in range(bulletCount):
		bullet.append(preload("res://Weapons/Bullets.tscn"))
func _input(event):
	if event is InputEventMouseMotion:
		followMouse()
			
func _process(_delta):
	if Input.is_action_pressed("shoot") and can_fire:
		if !cam_shake.is_shaking:
			cam.offset = lerp(cam.offset, (Vector2.RIGHT*3).rotated(rotation), 0.5)
			shaketimer.start()

		if shootCount >= magazineVol:
			checkReload()
		else:
			can_fire = false
			for i in range(bulletCount):
				var bullet_instance = bullet[i].instance()
				bullet_instance.rotation = rotation+rand_range(-0.1,0.1)
				bullet_instance.global_position = $GunSprite/Position2D.global_position+Vector2(rand_range(-10,10),rand_range(-10,10))
				get_node("/root").add_child(bullet_instance)
			shootCount+=1
			stats.bullet_count(weapon_name, get_parent().name, shootCount)
			$fireCD.start(fireCD)
	if Input.is_action_just_pressed("reload") and notReloading:
		can_fire = false
		$reloadCD.start(reloadCD/magazineVol)

func _on_ShakeTimer_timeout():
	cam.offset = lerp(cam.offset,Vector2.ZERO, 0.5)

func followMouse():
	look_at(get_global_mouse_position())
	# keep rotation_degrees between 0 and 360
	rotation_degrees = fposmod(rotation_degrees, 360.0)
	if rotation_degrees > 90 && rotation_degrees < 270:
		$GunSprite.set_scale(Vector2(0.5,-0.5))
	else:
		$GunSprite.set_scale(Vector2(0.5,0.5))

func checkReload():
	can_fire = false
	notReloading = false
	stats.bullet_count(weapon_name, get_parent().name, shootCount)
	$reloadCD.start(reloadCD)

func _on_fireCD_timeout():
	can_fire = true

func _on_reloadCD_timeout():
	shootCount = 0
	stats.bullet_count(weapon_name, get_parent().name, shootCount)
	can_fire = true
	notReloading = true


func _on_readyTimer_timeout():
	can_fire = true
