extends Node2D
onready var coll = $hitbox/CollisionShape2D
var stats = PlayerStats
var timerStop = true
var can_fire = false
export var weapon_name = "dart"
export var noise = 30
export var speed = 1200
export var stay_time = 0.5
export var readyCD = 0.5
onready var stay_timer = $stay_timer
onready var tar_pos
onready var coming_back = false
onready var shooting = false

enum{FIRE, IDLE}
var state = IDLE

func _ready():
	stats.playerStats["current_weapon"] = weapon_name
	$readyTImer.start(readyCD)

func _process(delta):
	if Input.is_action_pressed("shoot") and not(shooting) and can_fire:
		shooting = true
		tar_pos = get_global_mouse_position()+Vector2(rand_range(-noise,noise), rand_range(-noise,noise))
		state = FIRE
	match state:
		IDLE:
			idle()
		FIRE:
			firing(delta)

func idle():
	$hitbox.damage = 7
	
func firing(delta):
	$hitbox.damage = 20
	if not(coming_back):
		global_position = global_position.move_toward(tar_pos, speed*delta)
		if global_position.distance_to(tar_pos) < 0.1 and timerStop:
			stay_timer.start(stay_time)
			timerStop = false
	else:
		global_position = global_position.move_toward(get_parent().global_position, speed*delta)
		if global_position.distance_to(get_parent().global_position) < 0.1:
			coming_back = false
			shooting = false
			state = IDLE

func _on_Timer_timeout():
	coll.set_deferred("disabled", true)
	coll.set_deferred("disabled", false)


func _on_stay_timer_timeout():
	coming_back = true
	timerStop = true


func _on_readyTImer_timeout():
	can_fire = true
