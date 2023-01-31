extends Node

var max_health = 1500
onready var health = max_health  setget set_health, get_health

signal no_health

var weapons = {
	"scar":true
}
var mags = {
	"scar":30
}
var bullets = {
	"normal": 1000,
	"push_off":1000
}

func _ready():
	pass

func set_health(value):
	health  = value
	if health <= 0:
		emit_signal("no_health")
func set_mag(weapon_name, value):
	mags[weapon_name] = value

func set_bullet_reserve(weapon_name, value):
	bullets[weapon_name] = value

func get_health():
	return health

func get_mag(weapon_name):
	return mags[weapon_name]

func get_bullet_reserve(bullet_type):
	return bullets[bullet_type]
