extends Node2D
var stats = PlayerStats
export(String) var weapon_name
export(float) var fireCD
export(int) var magazineVol
export(float) var reloadCD
export(float) var readyCD
export(int) var damage
export(int) var bullet_speed
export(int) var bullet_health
export(float) var recoil
onready var shootCount = 0
var can_fire = false
var notReloading = true
var bullet = preload("res://Weapons/Bullets.tscn")
onready var shaketimer = $ShakeTimer
onready var cam_shake = get_node("/root/World/Camera2D/shake")
onready var cam = get_node("/root/World/Camera2D")
onready var sound_player = $AudioStreamPlayer2D
func _ready():
	stats.playerStats["current_weapon"] = weapon_name
	followMouse()
	shootCount = stats.get_bullet_count(get_parent().name)
	if shootCount >= magazineVol:
		checkReload()
	else:
		$readyTimer.start(readyCD)
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
			if !cam_shake.is_shaking:
				cam.offset = lerp(cam.offset, (Vector2.RIGHT*3).rotated(rotation), 0.5)
				shaketimer.start()
			can_fire = false
			sound_player.play()
			var bullet_instance = bullet.instance()
			bullet_instance.damage = damage
			bullet_instance.speed = bullet_speed
			bullet_instance.health = bullet_health
			bullet_instance.rotation = rotation+rand_range(-recoil,recoil)
			bullet_instance.global_position = $GunSprite/Position2D.global_position
			get_node("/root").add_child(bullet_instance)
			shootCount+=1
			stats.bullet_count(weapon_name, get_parent().name, shootCount)
			$fireCD.start(fireCD)

	if Input.is_action_just_pressed("reload"):
		can_fire = false
		$reloadCD.start(reloadCD)

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

func _on_reloadCD_timeout():
	shootCount = 0
	stats.bullet_count(weapon_name, get_parent().name, shootCount)
	can_fire = true
	notReloading = true

func _on_fireCD_timeout():
	can_fire = true

func _on_readyTimer_timeout():
	can_fire = true
