extends KinematicBody2D

export var maxSpeed = 250000

const dash_speed = 800000
const dash_duration = 0.2

var stats = PlayerStats

onready var sprite = $Sprite
onready var hurtbox = $hurtbox
onready var dash = $Dash

func _ready():
	stats.connect("no_health", self, "queue_free")

	
func _process(delta):
	var move_direction = get_move_direction()
	
	if Input.is_action_just_pressed("dash") && dash.can_dash && !dash.is_dashing():
		dash.start_dash(sprite, dash_duration, move_direction)
			
	var speed = dash_speed if dash.is_dashing() else maxSpeed
	
	

	var velocity = move_direction.normalized() * speed * delta
	move_and_slide(velocity)
	

func get_move_direction():
	return Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)
	
			
func _on_hurtbox_area_entered(area):
	if dash.is_dashing(): return
	stats.health -= area.damage
	hurtbox.start_invin(0.5)
	print("ouch")



