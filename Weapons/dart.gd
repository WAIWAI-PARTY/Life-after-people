extends Node2D
onready var coll = $hitbox/CollisionShape2D
onready var itself = load("res://Weapons/dart.tscn")

var stats = PlayerStats
var can_fire = false
var is_temp = false
var angle  = 0
var level = 4
var is_first_time = true

export var weapon_name = "dart"
export var noise = 0.001
export var speed = 1200
export var stay_time = 0.5
export var special_stay_time = 8
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
		state = FIRE
		tar_pos = get_global_mouse_position()+Vector2(rand_range(0,30), rand_range(0,30))
	elif Input.is_action_just_pressed("special") and not(shooting):
		state = SPECIAL
	match state:
		IDLE:
			idle()
		FIRE:
			firing(delta)
		SPECIAL:
			special(delta, level)

func idle():
	stats.bullet_count(weapon_name, get_parent().name, 0)
	$hitbox.damage = 7
	
func firing(delta):
	shooting = true
	stats.bullet_count(weapon_name, get_parent().name, 1)
	$hitbox.damage = 20
	if not(coming_back):
		global_position = global_position.move_toward(tar_pos, speed*delta)
		if global_position.distance_to(tar_pos) < 0.1 and stay_timer.is_stopped():
			stay_timer.start(stay_time)
	else:
		global_position = global_position.move_toward(get_parent().global_position, speed*delta)
		if global_position.distance_to(get_parent().global_position) < 0.1:
			if is_temp:
				queue_free()
			position = Vector2.ZERO
			coming_back = false
			shooting = false
			state = IDLE

func special(delta, i):
	shooting = true
	if i > 1 and is_first_time:
		is_first_time = false
		var it = itself.instance()
		it.level = i-1
		it.state = SPECIAL
		it.is_temp = true
		get_parent().add_child(it)
	angle+=speed*delta*i
	if angle >= 360:
		angle = 0
	var x = 60*i * sin(PI * 2 * angle / 360);
	var y = 60*i * cos(PI * 2 * angle / 360);
	tar_pos = Vector2(x,y)+get_parent().get_parent().global_position
	$hitbox.damage = 20

	if not(coming_back):
		global_position = global_position.move_toward(tar_pos, speed*delta)
		if stay_timer.is_stopped():
			stay_timer.start(special_stay_time)
	else:
		global_position = global_position.move_toward(get_parent().global_position, speed*delta)
		if global_position.distance_to(get_parent().global_position) < 0.1:
			if is_temp:
				queue_free()
			position = Vector2.ZERO
			coming_back = false
			shooting = false
			is_first_time = true
			state = IDLE

func _on_Timer_timeout():
	coll.set_deferred("disabled", true)
	coll.set_deferred("disabled", false)

func _on_stay_timer_timeout():
	coming_back = true

func _on_readyTimer_timeout():
	can_fire = true
