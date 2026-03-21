extends AnimatableBody2D

@export var speed = 800.0

var base_scale : Vector2

func _ready() -> void:
	base_scale = scale

func _process(delta: float) -> void:
	move2(delta)
	
func move1(delta):
	var mouse_pos = get_global_mouse_position()
	global_position.x = mouse_pos.x

func move2(delta):
	var mouse_pos = get_global_mouse_position()
	var current_x = global_position.x
	var diff = mouse_pos.x - current_x
	
	var scale_y = 1 - abs(2 * diff / get_viewport_rect().size.x)
	scale = base_scale * Vector2(1, scale_y)

	#global_position.x += diff * 30 * delta
