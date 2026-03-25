extends RigidBody2D

@export var speed : float = 500

func _physics_process(delta: float) -> void:
	var direction = linear_velocity.normalized()
	linear_velocity = direction * speed


func _on_body_entered(body: Node) -> void:
	$AnimationPlayer.play("bounce")
	$AudioStreamPlayer.play()
	
	if body is Block:
		body.destroy()
