extends Area2D
onready var coll = $hitbox/CollisionShape2D
export var noise = 30
export var speed = 800
export var stay_time = 0.5
onready var tar_pos
onready var coming_back = false
onready var shooting = false
enum{firing, idle}
var state = idle
 
func _process(delta):
	if Input.is_action_pressed("shoot") and not(shooting):
		shooting = true
		tar_pos = get_global_mouse_position()+Vector2(rand_range(-noise,noise), rand_range(-noise,noise))
		state = firing
	match state:
		idle:
			idle()
		firing:
			firing(delta)

func idle():
	$hitbox.damage = 7
	
func firing(delta):
	$hitbox.damage = 20
	if not(coming_back):
		global_position = global_position.move_toward(tar_pos, speed*delta)
		if global_position.distance_to(tar_pos) < 1:
			yield(get_tree().create_timer(stay_time),"timeout")
			coming_back = true
	else:
		global_position = global_position.move_toward(get_node("../").global_position, speed*delta)
		if global_position.distance_to(get_node("../").global_position) < 1:
			coming_back = false
			shooting = false
			state = idle
	
func _on_Timer_timeout():
	coll.set_deferred("disabled", true)
	coll.set_deferred("disabled", false)
