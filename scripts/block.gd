class_name Block
extends StaticBody2D

const UPGRADE = preload("uid://26b7711ggomk")

enum BlockType { REGULAR, DROP_UPGRADE, EXPLODE }

@export var block_type : BlockType = BlockType.REGULAR

var destroyed : bool = false

func _ready() -> void:
	var r = randf()
	if r < 0.1: block_type = BlockType.EXPLODE
	elif r < 0.2: block_type = BlockType.DROP_UPGRADE
	
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
	if destroyed: return
	destroyed = true
	$CollisionShape2D.disabled = true
	
	match block_type:
		BlockType.REGULAR: pass
		BlockType.DROP_UPGRADE:
			var upgrade := UPGRADE.instantiate()
			get_tree().root.get_node("MainScene").add_child(upgrade)
			upgrade.global_position = global_position
			
		BlockType.EXPLODE:
			play_explosion_animation()
			await get_tree().create_timer(0.5).timeout
			for body in $ExplosionArea.get_overlapping_bodies():
				if body is Block: 
					body.destroy()
					
		_: push_error("Something has gone wrong")
		
	play_destroy_animation()

func play_explosion_animation():
	$ExplosionAnimation.show()
	$ExplosionAnimation.play("explode")
	$ExplosionAnimation.top_level = true
	$ExplosionAnimation.global_position = global_position
	$ExplosionAudio.play()
	

func play_destroy_animation():
	var direction = randf_range(-1, 1)
	var end_pos = global_position + Vector2.DOWN * 200 + Vector2.RIGHT * direction * 100
	var end_rot = global_rotation + 4 * PI * direction
	
	var tween = create_tween()
	tween.tween_property(self, 'global_position:x', end_pos.x, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	# tween.set_parallel()
	tween.parallel().tween_property(self, 'global_position:y', end_pos.y, 0.5).set_trans(Tween.TRANS_LINEAR)
	tween.parallel().tween_property(self, 'scale', Vector2(0,0), 0.5).set_trans(Tween.TRANS_LINEAR)
	tween.parallel().tween_property(self, 'global_rotation', end_rot, 0.5)
	tween.parallel().tween_property(self, 'modulate:a', 0, 0.5)
	
	# tween.tween_callback(queue_free) (isto kao ovo dole)
	await tween.finished
	queue_free()
