extends Sprite2D


func _ready() -> void:
	material.set("shader_parameter/spin_amount", 0.1)
	var tween = create_tween()
	tween.tween_property(material, "shader_parameter/spin_amount", 0.36, 1).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
