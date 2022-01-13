extends KinematicBody2D

export(int) var maxSpeed = 100
export(int) var aclt = 800
export(int) var frict = 1000
export(float) var dash_duration = 0.2
export(float) var b_time_duration = 0.5
var stats = PlayerStats
var velocity = Vector2.ZERO
var speed_factor = 1
var input_vector = Vector2.ZERO
enum {WALK, DASH, B_TIME}
var state = WALK
onready var sprite = $Sprite
onready var hurtbox = $hurtbox
onready var dash = $Dash
onready var bullet_time = $Bullet_Time
onready var blink = $Blink

func _ready():
	randomize()
	stats.connect("no_health", self, "queue_free")

func _process(delta):
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	maxSpeed = 450 if dash.is_dashing() else 100*speed_factor
	aclt = 10000*speed_factor if dash.is_dashing() else 800*speed_factor
	frict = 1000*speed_factor
	match state:
		WALK:
			walk_state(delta)
		DASH:
			dash_state()
		B_TIME:
			b_time_state()
				
	velocity = move_and_slide(velocity)

func walk_state(delta):
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector*maxSpeed, aclt*delta*speed_factor)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, frict*delta)
	if Input.is_action_just_pressed("dash") && dash.can_dash && !dash.is_dashing():
		state = DASH
	if Input.is_action_just_pressed("bullet_time") and bullet_time.can_bullet and !bullet_time.is_bulleting():
		state = B_TIME

func dash_state():
	dash.start_dash(sprite, dash_duration, input_vector)
	state = WALK

func b_time_state():
	bullet_time.start_bullet_time(sprite, b_time_duration)
	state = WALK

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
