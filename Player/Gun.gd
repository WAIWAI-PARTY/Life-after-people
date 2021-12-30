extends Sprite


var can_fire = true

func _ready():
	set_as_toplevel(true)
	
func _physics_process(delta):
	position.x = lerp(position.x, get_parent().position.x+9, 0.7)
	position.y = lerp(position.y, get_parent().position.y+4, 0.8)
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	

