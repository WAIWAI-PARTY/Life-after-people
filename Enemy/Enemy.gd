extends KinematicBody2D

onready var stats = $Stats
onready var pdz = $PlayerDetectionZone
onready var AnimPlayer = $AnimationPlayer
onready var AnimTree = $AnimationTree
onready var AnimState = AnimTree.get("parameters/playback")
onready var slimeSprite = $Sprite
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

func _process(delta):
	match state:
		idle:
			AnimState.travel("idle")
			velocity = velocity.move_toward(Vector2.ZERO, frict*delta)
			seek_player()
			if wand_con.get_time_left() == 0:
				pick_and_start()
		wander:
			AnimState.travel("walk")
			seek_player()
			if wand_con.get_time_left() == 0:
				pick_and_start()
			move(wand_con.target_pos,delta)
			if global_position.distance_to(wand_con.target_pos)<=4:
				pick_and_start()
		chase:
			var player = pdz.player
			AnimState.travel("walk")
			if pdz.can_see_player():
				move(player.global_position,delta)
			else:
				state = idle
	slimeSprite.flip_h = velocity.x > 0
	if soft_coll.iscolliding():
		velocity+=soft_coll.get_push_vector()*delta*400
	velocity = move_and_slide(velocity)
func move(pos,delta):
	var direction = global_position.direction_to(pos)
	velocity = velocity.move_toward(direction*max_speed, aclt*delta)

func pick_and_start():
	state = pick_state()
	wand_con.start_wand_timer(rand_range(1,3))

func seek_player():
	if pdz.can_see_player():
		state = chase

func pick_state(state_list = [idle,wander]):
	state_list.shuffle()
	return state_list.pop_front()

func _on_hurtbox_area_entered(area):
	blink.play("blink_start")
	stats.health -= area.damage

func _on_Stats_no_health():
	queue_free()
	var edf = deathEffect.instance()
	get_parent().add_child(edf)
	edf.global_position = global_position

func _on_AttackRange_area_entered(_area):
	AnimState.travel("attack")
