extends RigidBody2D

@export var ball_velocity : float = 500.0

func _ready() -> void:
	set_deferred("freeze", true)
	await get_tree().create_timer(1).timeout
	set_deferred("freeze", false)
	linear_velocity = Vector2(1, -1)

func _physics_process(_delta: float) -> void:
	var direction = linear_velocity.normalized()
	linear_velocity = direction * ball_velocity
	 
func _on_body_entered(body: Node) -> void:
	if body is Block:
		body.destroy.call_deferred()
	$AnimationPlayer.play("bounce")
	$AudioStreamPlayer.play()
