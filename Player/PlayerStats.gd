extends Node

onready var playerStats = {
	"max_health": 1500,
	"health": 100,
	"current_weapon": "dart",
	"dart": {
		"slot1":"ready",
		"slot2":"ready",
		"slot3":"ready",
		"slot4":"ready",
		"slot5":"ready",
		"slot6":"ready"
	},
	"pistol": {
		"slot1":0,
		"slot2":0,
		"slot3":0,
		"slot4":0,
		"slot5":0,
		"slot6":0
	},
	"shotgun": {
		"slot1":0,
		"slot2":0,
		"slot3":0,
		"slot4":0,
		"slot5":0,
		"slot6":0
	}
}
onready var health = playerStats["max_health"]  setget set_health, get_health
signal no_health
func _ready():
	pass
func set_health(value):
	playerStats["health"]  = value
	if playerStats["health"] <= 0:
		emit_signal("no_health")

func get_health():
	return playerStats["health"]

func bullet_count(weapon_name, slot, value):
	playerStats[weapon_name][slot] = value

func get_bullet_count(slot):
	return playerStats[playerStats.current_weapon][slot]
