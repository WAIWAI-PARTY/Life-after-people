extends KinematicBody2D
onready var stats = $Stats

func _on_hurtbox_area_entered(area):
	stats.health -= area.damage

func _on_Stats_no_health():
	queue_free()
