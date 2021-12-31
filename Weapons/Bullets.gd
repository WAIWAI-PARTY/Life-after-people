extends Area2D

export var speed = 150

func _ready():
	set_as_toplevel(true)

func _process(delta):
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullets_body_entered(_body):
	queue_free()
