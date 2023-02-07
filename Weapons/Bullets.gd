extends KinematicBody2D

export(int) var speed
export(int) var health
export(int) var damage
onready var flying_timer = $FlyingTimer
onready var hitbox = $hitbox
onready	var bullet_smoke_scene = preload("res://Effect/bullet_smoke.tscn")
onready	var bullet_flash_scene = preload("res://Effect/bullet_hit_flash.tscn")
func _ready():
	set_as_toplevel(true)
	hitbox.damage = damage
	flying_timer.start()

func _process(delta):
	var coll = move_and_collide((Vector2.RIGHT).rotated(rotation)*speed*delta)
	if coll!=null:
		var flash = bullet_flash_scene.instance()
		var smoke = bullet_smoke_scene.instance()
		smoke.global_position = coll.position
		flash.global_position = coll.position
		smoke.rotation = rotation
		flash.rotation = rotation
		get_parent().add_child(smoke)
		get_parent().add_child(flash)
		queue_free()

func _on_hitbox_area_entered(_area):
		queue_free()
	
func _on_FlyingTimer_timeout():
	queue_free()
