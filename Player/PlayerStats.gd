extends Node

onready var playerStats = {
	"max_health": 1500,
	"health": 100,
	"current_weapon": "",
	"dart": {
		"mag_vol":1,
		"slot1":0,
	},
	"pistol": {
		"mag_vol":7,
		"slot1":0,
	},
	"shotgun": {
		"mag_vol":2,
		"slot1":0,
	},
	"scar": {
		"mag_vol":30,
		"slot1":0,
	},
	"sniper": {
		"mag_vol":10,
		"slot1":0,
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
	if playerStats["current_weapon"]:
		return playerStats[playerStats["current_weapon"]][slot]
	
func get_weapon_state(slot):
	if playerStats["current_weapon"]:
		if playerStats[playerStats["current_weapon"]][slot]<playerStats[playerStats["current_weapon"]]["mag_vol"]:
			return str(playerStats[playerStats["current_weapon"]]["mag_vol"]-playerStats[playerStats["current_weapon"]][slot])
		else:
			return "reload"
	else:
		return "no weapon"
