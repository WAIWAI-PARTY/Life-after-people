extends Area2D

var invin = false
var is_dashing = false
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
	$CollisionShape2D.set_deferred("disabled", true)


func _on_hurtbox_invin_ended():
	$CollisionShape2D.set_deferred("disabled", false)


func _on_hurtbox_area_entered(_area):
	if is_dashing:
		print(is_dashing)
		return
	print(is_dashing,"2")
	var hf = hiteffect.instance()
	get_parent().add_child(hf)
	hf.global_position = global_position


func _on_Dash_dash_start():
	is_dashing = true

func _on_Dash_dash_end():
	is_dashing = false
