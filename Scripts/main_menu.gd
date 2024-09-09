extends Node

@onready var tap_sound = $TapSound
@onready var menu_music = $MenuMusic
@onready var bg_elements = $bg_elements

var center : Vector2 
@onready var background = $Background



func _ready():
	menu_music.play(0.5)
	center = Vector2(10, 20)
	
	
func _process(delta):
	var tween = bg_elements.create_tween()
	
	var offset = center - bg_elements.get_global_mouse_position() * 0.05
	
	tween.tween_property(bg_elements, "position", offset, 1.0)

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
		get_tree().change_scene_to_file("res://scenes/levels/test_level.tscn")		


func _on_play_button_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")



func _on_quit_pressed():
	get_tree().quit() 
