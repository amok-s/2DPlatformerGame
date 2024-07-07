extends Node
@onready var game_manager = %GameManager







func _on_dust_animation_looped():
	queue_free()
