extends KinematicBody2D
onready var stats = $Stats
onready var pdz = $PlayerDetectionZone
onready var AnimPlayer = $AnimationPlayer
onready var AnimTree = $AnimationTree
onready var AnimState = AnimTree.get("parameters/playback")
onready var slimeSprite = $Sprite
export(int) var aclt = 300
export(int) var max_speed = 50
export(int) var frict = 200
const deathEffect = preload("res://Effect/Explosion_Effect.tscn")
enum {
	idle,
	wander,
	chase
}
var state = idle
var velocity = Vector2.ZERO
func _process(delta):
	match state:
		idle:
			AnimState.travel("idle")
			velocity = velocity.move_toward(Vector2.ZERO, frict*delta)
			seek_player()
		wander:
			pass
		chase:
			var player = pdz.player
			AnimState.travel("walk")
			if pdz.can_see_player():
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction*max_speed, aclt*delta)
			else:
				state = idle
			slimeSprite.flip_h = velocity.x > 0
	
	velocity = move_and_slide(velocity)
			
func seek_player():
	if pdz.can_see_player():
		state = chase
	
func _on_hurtbox_area_entered(area):
	stats.health -= area.damage

func _on_Stats_no_health():
	queue_free()
	var edf = deathEffect.instance()
	get_parent().add_child(edf)
	edf.global_position = global_position


func _on_hitbox_area_entered(area):
	AnimState.travel("attack")
