extends KinematicBody2D

const bullet_scene = preload("res://Enemy/EnemyBullet.tscn")
onready var shoot_timer = $ShootTimer
onready var rotater = $Rotater

export var rotate_speed = 200
export var  shooter_timer_wait_time = 0.1
export var  spawn_point_count = 2
export var  radius = 10


onready var stats = $Stats
onready var pdz = $PlayerDetectionZone
onready var MrC = $Sprite
onready var soft_coll = $SoftCollision
onready var blink = $Blink
onready var hurtbox = $hurtbox
onready var wand_con = $WanderController

export(int) var aclt = 300
export(int) var max_speed = 50
export(int) var frict = 200

const deathEffect = preload("res://Effect/Explosion_Effect.tscn")

enum {
	idle,
	wander,
	chase
}

var state = pick_state()
var velocity = Vector2.ZERO


func _ready():
	var step = 2*PI / spawn_point_count
	
	for i  in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)

	shoot_timer.wait_time = shooter_timer_wait_time
	shoot_timer.start()


func _process(delta):
	rotate_shoot_point(delta)
	match state:
		idle:
			velocity = velocity.move_toward(Vector2.ZERO, frict*delta)
			seek_player()
			if wand_con.get_time_left() == 0:
				pick_and_start()
		wander:
			seek_player()
			if wand_con.get_time_left() == 0:
				pick_and_start()
			move(wand_con.target_pos,delta)
			if global_position.distance_to(wand_con.target_pos)<=4:
				pick_and_start()
		chase:
			var player = pdz.player
			if pdz.can_see_player():
				if global_position.distance_to(player.global_position)<=70:
					velocity = Vector2.ZERO
				else:
					move(player.global_position,delta)
			else:
				state = idle
	MrC.flip_h = velocity.x > 0
	if soft_coll.iscolliding():
		velocity+=soft_coll.get_push_vector()*delta*400
	velocity = move_and_slide(velocity)

func _on_ShootTimer_timeout():
	for s in rotater.get_children():
		var bullet = bullet_scene.instance()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation
		

func move(pos,delta):
	var direction = global_position.direction_to(pos)
	velocity = velocity.move_toward(direction*max_speed, aclt*delta)

func _on_hurtbox_invin_start():
	blink.play("blink_start")


func _on_hurtbox_invin_ended():
	blink.play("blink_end")


func _on_Stats_no_health():
	queue_free()
	var edf = deathEffect.instance()
	get_parent().add_child(edf)
	edf.global_position = global_position
	
func rotate_shoot_point(delta):
	var new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)

func pick_state(state_list = [idle,wander]):
	state_list.shuffle()
	return state_list.pop_front()

func seek_player():
	if pdz.can_see_player():
		state = chase

func pick_and_start():
	state = pick_state()
	wand_con.start_wand_timer(rand_range(1,3))


func _on_hurtbox_area_entered(area):
	stats.health-=area.damage
	hurtbox.start_invin(0.1)
