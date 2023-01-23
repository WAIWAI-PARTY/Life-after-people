extends Node2D

onready var muzzle_anim = preload("res://Effect/muzzle_flash.tscn")

func _on_ranged_weapon_fire():
	var muzzle_ins = muzzle_anim.instance()
	muzzle_ins.position = $ranged_weapon/muzzle.position
	muzzle_ins.play("default")
	add_child(muzzle_ins)
