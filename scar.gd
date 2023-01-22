extends Node2D

export(int) var bullet_type = 0
export(int) var bullet_per_shot = 1
export(int) var accuracy = 10 
onready var bullets = [preload("res://Weapons/Bullets.tscn"), preload("res://Weapons/push_off_bullet.tscn")]
onready var BulletScene = bullets[bullet_type]
onready var muzzle = $muzzle
func _process(delta):
	look_at(get_global_mouse_position())
	rotation_degrees = fposmod(rotation_degrees, 360.0)
	if rotation_degrees > 90 && rotation_degrees < 270:
		set_scale(Vector2(1,-1))
	else:
		set_scale(Vector2(1,1))
