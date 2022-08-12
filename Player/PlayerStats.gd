extends Node

export var playerStats = {
	"max_health": 1500,
	"health": 100,
	"current_weapon": "dart",
	"dart": "infinite",
	"pistol": 0,
	"shotgun": 0
}
onready var health = playerStats["max_health"]  setget set_health, get_health
signal no_health
func set_health(value):
	playerStats["health"]  = value
	if playerStats["health"] <= 0:
		emit_signal("no_health")
func get_health():
	return playerStats["health"]

func bullet_count(weapon_name, slot, value):
	playerStats[weapon_name] = value

func get_bullet_count():
	return playerStats[playerStats.current_weapon]
