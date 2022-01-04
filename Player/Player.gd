extends KinematicBody2D

export(int) var maxSpeed = 60000

const dash_duration = 0.15

var stats = PlayerStats
var velocity = Vector2.ZERO

onready var sprite = $Sprite
onready var hurtbox = $hurtbox
onready var dash = $Dash

func _ready():
	stats.connect("no_health", self, "queue_free")

	
func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	maxSpeed = 300000 if dash.is_dashing() else 60000
	if Input.is_action_just_pressed("dash") && dash.can_dash && !dash.is_dashing():
		dash.start_dash(sprite, dash_duration, input_vector)
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector*maxSpeed
	else:
		velocity = Vector2.ZERO
	velocity = velocity*delta
	move_and_slide(velocity)

func _on_hurtbox_area_entered(area):
	if dash.is_dashing(): return
	stats.health -= area.damage
	hurtbox.start_invin(0.5)
	print("ouch")



