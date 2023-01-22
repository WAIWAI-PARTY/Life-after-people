extends KinematicBody2D

export(int) var maxSpeed = 100
export(int) var aclt = 800
export(int) var frict = 1000
export(float) var dash_duration = 0.2
export(float) var b_time_duration = 0.4

var velocity = Vector2.ZERO
var speed_factor = 1
var input_vector = Vector2.ZERO
enum {IDLE, WALK, DASH, B_TIME}
var state = IDLE

onready var sprite = $Sprite
onready var hurtbox = $hurtbox
onready var dash = $Dash
onready var blink = $Blink
onready var anim_tree = $AnimationTree
onready var AnimState = anim_tree.get("parameters/playback")
onready var anim_player = $AnimationPlayer


func _ready():
	randomize()
	PlayerStats.connect("no_health", self, "player_death_reset")

func _process(delta):
	$Sprite.flip_h = global_position>get_global_mouse_position()
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	maxSpeed = 450 if dash.is_dashing() else 100*speed_factor
	aclt = 10000*speed_factor if dash.is_dashing() else 800*speed_factor
	frict = 1000*speed_factor
	anim_tree["parameters/idle/TimeScale/scale"] = speed_factor
	anim_tree["parameters/walk/TimeScale/scale"] = speed_factor
	
	match state:
		IDLE:
			idle()
		WALK:
			walk_state(delta)
		DASH:
			dash_state()

	velocity = move_and_slide(velocity)

func walk_state(delta):
	AnimState.travel("walk")
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector*maxSpeed, aclt*delta*speed_factor)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, frict*delta)
	if Input.is_action_just_pressed("dash") && dash.can_dash && !dash.is_dashing():
		state = DASH
	elif velocity == Vector2.ZERO:
		state = IDLE

func dash_state():
	dash.start_dash(sprite, dash_duration, input_vector)
	state = WALK
func idle():
	AnimState.travel("idle")
	if Input.is_action_just_pressed("dash") && dash.can_dash && !dash.is_dashing():
		state = DASH
	elif input_vector != Vector2.ZERO:
		state = WALK

func _on_hurtbox_area_entered(area):
	if dash.is_dashing(): return
	blink.play("Blink_start")
	PlayerStats.health -= area.damage

func _on_Dash_dash_end():
	velocity = Vector2.ZERO

func player_death_reset():
	Engine.time_scale = 1
	queue_free()
