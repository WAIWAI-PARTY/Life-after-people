extends Area2D

var invin = false
signal invin_start
signal invin_ended
onready var timer = $Timer
const hiteffect = preload("res://Effect/hiteffect.tscn")
func start_invin(duaration):
	emit_signal("invin_start")
	self.invin = true
	timer.start(duaration)

func _on_Timer_timeout():
	emit_signal("invin_ended")
	self.invin = false


func _on_hurtbox_invin_start():
	set_deferred("monitoring", false)


func _on_hurtbox_invin_ended():
	set_deferred("monitoring", true)


func _on_hurtbox_area_entered(area):
	var hf = hiteffect.instance()
	get_parent().add_child(hf)
	hf.global_position = global_position
