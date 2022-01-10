extends KinematicBody2D

export(int) var maxSpeed = 100
export(int) var aclt = 800
export(int) var frict = 1000
const dash_duration = 0.2
onready var ghost_timer = $Dash/GhostTimer
var stats = PlayerStats
var velocity = Vector2.ZERO
var speed_factor = 1
var ghost_scene = preload("res://Player/DashGhost.tscn")

onready var sprite = $Sprite
onready var hurtbox = $hurtbox
onready var dash = $Dash
onready var blink = $Blink

func _ready():
	randomize()
	stats.connect("no_health", self, "queue_free")

func _process(delta):
	if Input.is_action_pressed("bullet_time"):
		speed_factor = 5
		ghost_timer.start()
		instance_ghost()
	elif Input.is_action_just_released("bullet_time"):
		speed_factor = 1
		ghost_timer.stop()
		velocity = Vector2.ZERO
		
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	maxSpeed = 450 if dash.is_dashing() else 100*speed_factor
	aclt = 10000*speed_factor if dash.is_dashing() else 800*speed_factor
	if Input.is_action_just_pressed("dash") && dash.can_dash && !dash.is_dashing():
		dash.start_dash(sprite, dash_duration, input_vector)
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector*maxSpeed, aclt*delta*speed_factor)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, frict*delta)
	velocity = move_and_slide(velocity)
func instance_ghost():
	var ghost: Sprite = ghost_scene.instance()
	get_parent().add_child(ghost)
	ghost.global_position = Vector2(global_position.x+1, global_position.y-6)
	ghost.texture = sprite.texture
	ghost.vframes = sprite.vframes
	ghost.hframes = sprite.hframes
	ghost.frame = sprite.frame
	ghost.flip_h = sprite.flip_h
func _on_hurtbox_area_entered(area):
	if dash.is_dashing(): return
	stats.health -= area.damage
	hurtbox.start_invin(0.5)

func _on_Dash_dash_end():
	velocity = Vector2.ZERO



func _on_hurtbox_invin_ended():
	blink.play("Blink_stop")

func _on_hurtbox_invin_start():
	blink.play("Blink_start")
