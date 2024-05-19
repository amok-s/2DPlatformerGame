extends Node
@onready var tap_sound = $TapSound


func _on_level_1_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		get_tree().change_scene_to_file("res://scenes/level1.tscn")



func _on_level_2_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		get_tree().change_scene_to_file("res://scenes/level2.tscn")
		



func _on_level_3_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		get_tree().change_scene_to_file("res://scenes/level3.tscn")
		



func scrolling_menu():
	var direction = Input.get_axis("left", "right")




