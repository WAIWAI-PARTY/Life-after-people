extends Area2D

export var speed = 150

onready var flying_timer = $FlyingTimer

func _ready():
	set_as_toplevel(true)
	flying_timer.start()
func _process(delta):
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_hitbox_area_entered(_area):
	queue_free()
	

func _on_FlyingTimer_timeout():
	queue_free()
