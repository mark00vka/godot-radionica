class_name Block
extends StaticBody2D

const BALL = preload("uid://kl7w55631dk2")

func _ready() -> void:
	var start_pos = global_position
	var start_scale = $Sprite2D.scale
	global_position.y -= 800
	$Sprite2D.scale = Vector2.ZERO
	
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(self, "global_position", start_pos, 0.5)\
			.set_delay(randf() / 4) \
			.set_trans(Tween.TRANS_CUBIC) \
			.set_ease(Tween.EASE_OUT)
	tween.tween_property($Sprite2D, "scale", start_scale, 0.5) \
		.set_delay(0.2)

func destroy():
	if randf() < 0.5:
		var ball = BALL.instantiate()
		var main_scene = get_tree().root.get_node("MainScene")
		main_scene.add_child.call_deferred(ball)
		ball.global_position = global_position
		
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.finished.connect($AudioStreamPlayer.queue_free)
	$AudioStreamPlayer.reparent(get_tree().root)
	queue_free()
