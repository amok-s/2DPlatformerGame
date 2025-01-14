extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var flash = $ColorRect.get_material()
	var tween = get_tree().create_tween()
	tween.tween_property(flash, "shader_parameter/outerRadius", 5, 3)
	var tween_2 = get_tree().create_tween()
	tween_2.tween_property(flash, "shader_parameter/MainAlpha", 0, 6)
	await get_tree().create_timer(7).timeout
	queue_free()
