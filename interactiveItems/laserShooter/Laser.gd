extends Area2D

onready var coll = $hitbox/CollisionShape2D
export var sustain = 0

func _on_Timer_timeout():
	if sustain > 0:
		coll.set_deferred("disabled", true)
		coll.set_deferred("disabled", false)
		sustain-=1
	else:
		queue_free()
