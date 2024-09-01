extends CanvasLayer
class_name ui

@export var player: CharacterBody2D
@export var game_manager: Node
@export var hearts_panel: Panel


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
		await get_tree().process_frame
		await get_tree().process_frame
		await get_tree().process_frame
	transform = original_position
		

func _process(delta):
	
	if player.taking_damage and (game_manager.lives != 0):
		ui_shake(0.2,5)
	
	
	
