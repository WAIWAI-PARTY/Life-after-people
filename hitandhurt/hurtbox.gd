extends Area2D

var is_dashing = false
const hiteffect = preload("res://Effect/hiteffect.tscn")

func _on_hurtbox_area_entered(_area):
	if is_dashing: return
	var hf = hiteffect.instance()
	get_parent().add_child(hf)
	hf.global_position = global_position


func _on_Dash_dash_start():
	is_dashing = true

func _on_Dash_dash_end():
	is_dashing = false
