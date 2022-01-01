
extends Node2D

var can_fire = true
var bullet = preload("res://Weapons/Bullets.tscn")


func _input(event):
	if event is InputEventMouseMotion:
		look_at(event.position)

		# keep rotation_degrees between 0 and 360
		rotation_degrees = fposmod(rotation_degrees, 360.0)
		if rotation_degrees > 90 && rotation_degrees < 270:
			$GunSprite.set_scale(Vector2(0.5,-0.5))
		else:
			$GunSprite.set_scale(Vector2(0.5,0.5))
			
func _process(delta):		
	if Input.is_action_pressed("shoot") and can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.rotation = rotation
		bullet_instance.global_position = $GunSprite/Position2D.global_position
		get_parent().add_child(bullet_instance)
		
		can_fire = false
		yield(get_tree().create_timer(0.2),"timeout")
		can_fire = true
