extends Node2D
const dash_delay = 1
onready var duration_timer = $DurationTimer
onready var ghost_timer = $GhostTimer
var ghost_scene = preload("res://Player/DashGhost.tscn")
var sprite
var can_bullet = true

onready var dash = $"../Dash"
func _process(_delta):
	if Input.is_action_just_pressed("bullet_time") and can_bullet and !is_bulleting():
		start_bullet_time(get_parent().sprite, get_parent().b_time_duration)
		get_parent().state = get_parent().WALK
func ghost_instance():
	var ghost: Sprite = ghost_scene.instance()
	get_parent().get_parent().add_child(ghost)
	ghost.global_position = Vector2(global_position.x, global_position.y-18)
	ghost.texture = sprite.texture
	ghost.vframes = sprite.vframes
	ghost.hframes = sprite.hframes
	ghost.frame = sprite.frame
	ghost.flip_h = sprite.flip_h

func start_bullet_time(sprite, duration):
	var player = get_node("/root/World/YSort/Player")
	player.speed_factor = 5
	Engine.time_scale = 0.2
	dash.can_dash = false
	self.sprite = sprite
	sprite.material.set_shader_param("mix_weight", 0.7)
	sprite.material.set_shader_param("whiten",true)
	duration_timer.wait_time = duration
	duration_timer.start()
	duration_timer.start()
	ghost_timer.start()
	ghost_instance()

func is_bulleting():
	return !duration_timer.is_stopped()

func end_bullet_time():
	dash.can_dash = true
	var player = get_node("/root/World/YSort/Player")
	player.speed_factor = 1
	player.velocity = Vector2.ZERO
	Engine.time_scale = 1
	ghost_timer.stop()
	sprite.material.set_shader_param("whiten", false)
	can_bullet = false
	yield(get_tree().create_timer(dash_delay), "timeout")
	can_bullet = true

func _on_DurationTimer_timeout():
	end_bullet_time()

func _on_GhostTimer_timeout():
	ghost_instance()
