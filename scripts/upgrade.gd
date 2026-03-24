extends Node2D

const BALL = preload("uid://di0oivugrdg5t")

var speed := 200.0

func _process(delta: float) -> void:
	global_position.y += speed * delta
	modulate = Color(randf(), randf(), randf())

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not Player: return
	
	var ball = BALL.instantiate()
	get_tree().root.get_node("MainScene/Balls").add_child.call_deferred(ball)
	ball.global_position = body.global_position + Vector2.UP * 40

	
	queue_free()
