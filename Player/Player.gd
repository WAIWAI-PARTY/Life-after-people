extends KinematicBody2D

export var maxSpeed = 100
export var acceleration = 1000
export var friction = 1000

export(PackedScene) var dash_object
export var dash_speed = 1000
export var dash_length = 0.2

var velocity = Vector2.ZERO
var stats = PlayerStats

var is_dashing : bool = false
var can_dash : bool = true
var dash_direction :Vector2

onready var ani = $Sprite
onready var hurtbox = $hurtbox

onready var dash_timer = $dash_timer
onready var dash_particles = $dash_particles

func _ready():
	stats.connect("no_health", self, "queue_free")
	dash_timer.connect("timeout",self,"dash_timer_timeout")

func dash_timer_timeout():
	is_dashing = false

func get_direction_from_input():
	var move_dir = Vector2()
	move_dir.x = -Input.get_action_strength("ui_right") + Input.get_action_strength("ui_left")
	move_dir.y =  Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	move_dir = move_dir.clamped(1)
	
	if(move_dir == Vector2(0,0)):
		if(ani.flip_h):
			move_dir.x = -1
		else:
			move_dir.x = 1
			
	return move_dir * dash_speed

func handle_dash(var delta):
	if(Input.is_action_just_pressed("dash") and can_dash):
		is_dashing = true
		can_dash = true
		dash_direction = get_direction_from_input()
		dash_timer.start(dash_length)
		
	if(is_dashing):
		var dash_node = dash_object.instance()
		dash_node.texture = ani.get_texture()
		dash_node.global_position = global_position
		dash_node.flip_h = ani.flip_h
		get_parent().add_child(dash_node)
		
		dash_particles.emitting = true
	else:
		dash_particles.emitting = false
		
func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector*maxSpeed, acceleration*delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	velocity = move_and_slide(velocity)
func _physics_process(delta):
	handle_dash(delta)
	
func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtbox.start_invin(0.5)
