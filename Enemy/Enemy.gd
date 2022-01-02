extends KinematicBody2D
onready var stats = $Stats
onready var pdz = $PlayerDetectionZone
onready var slimeAni = $slimeAnimation
export(int) var aclt = 300
export(int) var max_speed = 50
export(int) var frict = 200
const deathEffect = preload("res://Effect/Explosion_Effect.tscn")
const hiteffect = preload("res://Effect/hiteffect.tscn")
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
			slimeAni.animation = "idle"
			velocity = velocity.move_toward(Vector2.ZERO, frict*delta)
			seek_player()
		wander:
			pass
		chase:
			var player = pdz.player
			slimeAni.animation = "walk"
			if pdz.can_see_player():
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction*max_speed, aclt*delta)
			else:
				state = idle
			slimeAni.flip_h = velocity.x > 0
	
	velocity = move_and_slide(velocity)
			
func seek_player():
	if pdz.can_see_player():
		state = chase
	
func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	var hf = hiteffect.instance()
	get_parent().add_child(hf)
	hf.global_position = global_position

func _on_Stats_no_health():
	queue_free()
	var edf = deathEffect.instance()
	get_parent().add_child(edf)
	edf.global_position = global_position
