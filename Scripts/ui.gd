extends CanvasLayer
class_name ui

func ui_shake(duration: float, strenght: float) -> void:
	
	var original_position = Transform2D()
	original_position.origin = Vector2(0, 0)
	var shake_start_time: float = Time.get_ticks_msec() / 1000.0
	
	while (Time.get_ticks_msec() / 1000.0) - shake_start_time < duration:
		var x: float = randf_range(-strenght, strenght)
		var y: float = randf_range(-strenght, strenght)
		
		var t = Transform2D()
		t.origin = Vector2(x, y)
		transform = t
		if get_tree():
			await get_tree().process_frame
		if get_tree():
			await get_tree().process_frame
		#await get_tree().process_frame
	transform = original_position
		

func _ready():
	var original_modulate = $HeartsPanel.modulate
	$HeartsPanel.modulate = Color(1, 1, 1, 0)
	$CoinsPanel.modulate = Color(1, 1, 1, 0)
	var hearts_tween = get_tree().create_tween()
	hearts_tween.set_ease(Tween.EASE_IN_OUT)
	hearts_tween.tween_property($HeartsPanel, "modulate", original_modulate, 1.4)
	
	var fruits_tween = get_tree().create_tween()
	fruits_tween.set_ease(Tween.EASE_IN_OUT)
	fruits_tween.tween_property($CoinsPanel, "modulate", original_modulate, 1.4)
