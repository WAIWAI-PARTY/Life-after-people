extends Node2D

onready var start_pos = global_position
onready var target_pos = global_position
export(int) var wander_range = 64
func _ready():
	update_target_pos()
func update_target_pos():
	var target_vector = Vector2(rand_range(-wander_range,wander_range),rand_range(-wander_range,wander_range))
	target_pos = start_pos + target_vector
func _on_Timer_timeout():
	update_target_pos()
func start_wand_timer(duration):
	$Timer.start(duration)
func get_time_left():
	return $Timer.time_left
