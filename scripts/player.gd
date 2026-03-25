extends AnimatableBody2D

var starting_scale : Vector2

func _ready() -> void:
	starting_scale = $Sprite2D.scale

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var start_pos = global_position
	var diff = mouse_pos.x - start_pos.x
	global_position.x += diff * 0.1
	
	$Sprite2D.scale.y = starting_scale.y * (1 - \
					abs(diff / get_viewport_rect().size.x))
						
