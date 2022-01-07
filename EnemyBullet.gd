extends Node2D

const speed = 300

func _process(delta):
	position += transform.x * speed * delta
	
	

func _on_KillTimer_timeout():
	queue_free()


func _on_hitbox_area_entered(area):
	queue_free()
