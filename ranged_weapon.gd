extends Node2D

export(int) var max_ammo = 10
export(int) var reserve_ammo = 30 setget set_reserve_ammo
export(float) var max_recoil = 10.0
export(float) var reload_time = 1.0
export(float) var fire_rate = 0.13
export(int) var bullet_type = 0
export(int) var bullet_per_shot = 1
export(int) var accuracy = 10

var current_recoil = 0.0
var current_ammo = max_ammo
var recoil_degree_actual = 0

onready var _reload_timer := $ReloadTimer
onready var _shoot_timer := $ShootTimer

onready var bullets = [preload("res://Weapons/Bullets.tscn"), preload("res://Weapons/push_off_bullet.tscn")]
onready var BulletScene = bullets[bullet_type]

func _ready() -> void:
	_reload_timer.connect("timeout", self, "refill_ammo")

func _process(_delta: float) -> void:
	get_parent().look_at(get_global_mouse_position())
	get_parent().rotation_degrees = fposmod(get_parent().rotation_degrees, 360.0)+recoil_degree_actual
	if get_parent().rotation_degrees > 90 && get_parent().rotation_degrees < 270:
		get_parent().set_scale(Vector2(1,-1))
	else:
		get_parent().set_scale(Vector2(1,1))
		
	if not _reload_timer.is_stopped():
		return
	if Input.is_action_pressed("shoot"):
		if current_ammo > 0:
			shoot()
		else:
			clamp_down_recoil()
			reload()
	elif Input.is_action_just_pressed("reload") and current_ammo < max_ammo:
		reload()
	else:
		clamp_down_recoil()

func shoot() -> void:
	if not _shoot_timer.is_stopped():
		return
	current_ammo -= 1
	recoil_degree_actual = rand_range(-current_recoil, current_recoil)
	var recoil_increment = max_recoil*0.1
	current_recoil = clamp(current_recoil+recoil_increment, 0.0, max_recoil)
	for _i in range(bullet_per_shot):
		var bullet = BulletScene.instance()
		bullet.global_position = $muzzle.global_position
		bullet.rotation = get_parent().rotation+rand_range(-accuracy/1000,accuracy/1000)
		get_tree().get_root().add_child(bullet)

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

func clamp_down_recoil():
	var recoil_increment = max_recoil*0.02
	recoil_degree_actual = clamp(recoil_degree_actual-recoil_increment,0.0,max_recoil)
	current_recoil = recoil_degree_actual
