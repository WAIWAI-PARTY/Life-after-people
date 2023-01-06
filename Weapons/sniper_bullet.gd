extends KinematicBody2D

export(int) var speed
export(int) var health
export(int) var damage
onready var flying_timer = $FlyingTimer
onready var hitbox = $hitbox

func _ready():
	set_as_toplevel(true)
	hitbox.damage = damage
	flying_timer.start()

func _process(delta):
	move_and_slide((Vector2.RIGHT*speed).rotated(rotation))

func _on_hitbox_area_entered(_area):
	if health > 0:
		health-=1
	else:
		queue_free()
	
func _on_FlyingTimer_timeout():
	queue_free()

