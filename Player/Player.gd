extends KinematicBody2D

export(int) var maxSpeed = 100
export(int) var aclt = 800
export(int) var frict = 1000
const dash_duration = 0.2

var stats = PlayerStats
var velocity = Vector2.ZERO

onready var sprite = $Sprite
onready var hurtbox = $hurtbox
onready var dash = $Dash
onready var blink = $Blink
func _ready():
	stats.connect("no_health", self, "queue_free")

func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	maxSpeed = 450 if dash.is_dashing() else 100
	aclt = 10000 if dash.is_dashing() else 800
	if Input.is_action_just_pressed("dash") && dash.can_dash && !dash.is_dashing():
		dash.start_dash(sprite, dash_duration, input_vector)
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector*maxSpeed, aclt*delta)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, frict*delta)
	velocity = move_and_slide(velocity)

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
