extends Node2D


func _on_blocks_child_exiting_tree(_node: Node) -> void:
	if $Blocks.get_child_count() <= 1:
		get_tree().reload_current_scene.call_deferred()
