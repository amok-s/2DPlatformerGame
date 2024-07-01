extends Node
@onready var tap_sound = $TapSound
@onready var menu_music = $MenuMusic

func _ready():
	menu_music.play(0.5)
func _on_menu_music_finished():
	menu_music.play(0.3)

func _on_level_1_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")



func _on_level_2_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		get_tree().change_scene_to_file("res://scenes/levels/level2.tscn")
		



func _on_level_3_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		get_tree().change_scene_to_file("res://scenes/levels/level3.tscn")
		



func scrolling_menu():
	var direction = Input.get_axis("left", "right")







