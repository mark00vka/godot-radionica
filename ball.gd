extends RigidBody2D

@export var ball_velocity : float = 500.0

func _physics_process(_delta: float) -> void:
	var direction = linear_velocity.normalized()
	linear_velocity = direction * ball_velocity
	 

func _on_body_entered(body: Node) -> void:
	if body is Block:
		body.queue_free.call_deferred()
