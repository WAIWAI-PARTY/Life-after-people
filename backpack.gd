extends Node2D

onready var weapon = [
	preload("res://Weapons/scar.tscn"),
	preload("res://Weapons/shotgun.tscn"),
	preload("res://Weapons/pistol.tscn")
	]
onready var weapon_id = 0 setget addWeapon, get_weapon_id
func _ready():
	weapon_id = 0

func _input(event):
	if Input.is_action_just_pressed("scroll_up"):
		if self.weapon_id == 0:
			self.weapon_id = 2
		else:
			self.weapon_id -= 1
		print(self.weapon_id)
	elif Input.is_action_just_pressed("scroll_down"):
		if self.weapon_id == 2:
			self.weapon_id = 0
		else:
			self.weapon_id += 1
		print(self.weapon_id)
	if Input.is_action_just_pressed("weapon1"):
		self.weapon_id = 0
	if Input.is_action_just_pressed("weapon2"):
		self.weapon_id = 1
	if Input.is_action_just_pressed("weapon3"):
		self.weapon_id = 2

func addWeapon(value):
	weapon_id = value
	for slots in get_tree().get_nodes_in_group("weaponSlot"):
		for n in slots.get_children():
			if n:
				slots.call_deferred("remove_child", n)
	if weapon[value]:
		for slots in get_tree().get_nodes_in_group("weaponSlot"):
			slots.add_child(weapon[value].instance())
	else:
		pass
func get_weapon_id():
	return weapon_id
