class_name Block
extends StaticBody2D

func _ready() -> void:
	play_spawn_animation()
	
func play_spawn_animation():
	var end_pos := global_position
	global_position += Vector2.UP * 400.0
	scale = Vector2(0.1, 0.1)
	await get_tree().create_timer(randf()/4.0).timeout
	
	var tween = create_tween()
	tween.tween_property(self, 'global_position', end_pos, 0.5).set_trans(Tween.TRANS_CUBIC).set_delay(randf()/2.0)
	tween.parallel().tween_property(self, 'scale', Vector2(1,1), 0.5).set_trans(Tween.TRANS_LINEAR).set_delay(0.2)

func destroy():
	queue_free()
