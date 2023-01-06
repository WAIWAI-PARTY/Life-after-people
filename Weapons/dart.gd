extends Node2D
onready var coll = $hitbox/CollisionShape2D
onready var itself = load("res://Weapons/dart.tscn")

var stats = PlayerStats
var timerStop = true
var can_fire = false
var is_temp = false
var angle  = 0
var sp_timer = true

export var weapon_name = "dart"
export var noise = 0.001
export var speed = 1200
export var stay_time = 0.5
export var special_stay_time = 5
export var readyCD = 0.5
onready var stay_timer = $stay_timer
onready var tar_pos
onready var coming_back = false
onready var shooting = false
enum{FIRE, IDLE, SPECIAL}
var state = IDLE

func _ready():
	stats.playerStats["current_weapon"] = weapon_name
	$readyTimer.start(readyCD)

func _process(delta):
	if Input.is_action_pressed("shoot") and not(shooting) and can_fire:
		shooting = true
		tar_pos = get_global_mouse_position()+Vector2(rand_range(0,30), rand_range(0,30))
		state = FIRE
	elif Input.is_action_just_pressed("special") and not(shooting):
		state = SPECIAL
	match state:
		IDLE:
			idle()
		FIRE:
			firing(delta)
		SPECIAL:
			special(delta)

func idle():
	stats.bullet_count(weapon_name, get_parent().name, 0)
	$hitbox.damage = 7
	
func firing(delta):
	stats.bullet_count(weapon_name, get_parent().name, 1)
	$hitbox.damage = 20
	if not(coming_back):
		global_position = global_position.move_toward(tar_pos, speed*delta)
		if global_position.distance_to(tar_pos) < 0.1 and timerStop:
			stay_timer.start(stay_time)
			timerStop = false
	else:
		global_position = global_position.move_toward(get_parent().global_position, speed*delta)
		if global_position.distance_to(get_parent().global_position) < 0.1:
			if is_temp:
				queue_free()
			position = Vector2.ZERO
			coming_back = false
			shooting = false
			state = IDLE

func special(delta):
	if sp_timer:
		$special_stepper.start()
		sp_timer = false
	if angle >= 360:
		angle = 0
	var x = 50 * sin(PI * 2 * angle / 360);
	var y = 50 * cos(PI * 2 * angle / 360);
	print(str(x)+","+str(y))
	tar_pos = Vector2(x,y)+get_parent().get_parent().global_position
	$hitbox.damage = 20
	if not(coming_back):
		global_position = global_position.move_toward(tar_pos, speed*delta)
		if timerStop:
			stay_timer.start(special_stay_time)
			timerStop = false
	else:
		global_position = global_position.move_toward(get_parent().global_position, speed*delta)
		if global_position.distance_to(get_parent().global_position) < 0.1:
			if is_temp:
				queue_free()
			position = Vector2.ZERO
			coming_back = false
			shooting = false
			sp_timer = true
			state = IDLE

func _on_Timer_timeout():
	coll.set_deferred("disabled", true)
	coll.set_deferred("disabled", false)

func _on_stay_timer_timeout():
	coming_back = true
	timerStop = true
	$special_stepper.stop()

func _on_readyTimer_timeout():
	can_fire = true

func _on_special_stepper_timeout():
	angle+=20
