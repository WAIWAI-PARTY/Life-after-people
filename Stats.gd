extends Node
export(int) var max_health
onready var health = max_health setget set_health, get_health
onready var bullet_count

export(Dictionary) var playerstat = {
	"max_health": 1500
}

signal no_health
func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")
func get_health():
	return health
