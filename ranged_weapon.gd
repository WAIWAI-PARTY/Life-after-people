extends Node2D

export(int) var max_ammo = 10
export(int) var reserve_ammo = 30 setget set_reserve_ammo

export(float) var reload_time = 1.0
var current_ammo = max_ammo
export(float) var fire_rate = 0.13

onready var _shoot_position = get_parent().muzzle

onready var _reload_timer := $ReloadTimer
onready var _shoot_timer := $ShootTimer
onready var camera = get_tree().get_nodes_in_group("camera")[0]
onready var bullet_type = get_parent().bullet_type
onready var bullet_per_shot = get_parent().bullet_per_shot

func _ready() -> void:
	_reload_timer.connect("timeout", self, "refill_ammo")
	refill_ammo()


func _process(_delta: float) -> void:
	if not _reload_timer.is_stopped():
		return

	if Input.is_action_pressed("shoot"):
		if current_ammo > 0:
			shoot()
		else:
			reload()
	elif Input.is_action_just_pressed("reload") and current_ammo < max_ammo:
		reload()


func shoot() -> void:
	if not _shoot_timer.is_stopped():
		return
	current_ammo -= 1
	for i in range(bullet_per_shot):
		var bullet = get_parent().BulletScene.instance()
		bullet.global_position = get_parent().muzzle.global_position
		bullet.rotation = get_parent().rotation+rand_range(-get_parent().accuracy/100,get_parent().accuracy/100)
		add_child(bullet)

	_shoot_timer.start(fire_rate)

func reload() -> void:
	if reserve_ammo <= 0:
		return
	
	_reload_timer.start(reload_time)

func refill_ammo() -> void:
	var ammo_missing = max_ammo - current_ammo
	
	if reserve_ammo >= ammo_missing:
		set_reserve_ammo(reserve_ammo - ammo_missing)
		current_ammo = max_ammo
	else:
		current_ammo += reserve_ammo
		set_reserve_ammo(0)

func set_reserve_ammo(value: int) -> void:
	reserve_ammo = value


func _on_shaketimer_timeout():
	camera.offset = lerp(camera.offset,Vector2.ZERO, 0.5)
