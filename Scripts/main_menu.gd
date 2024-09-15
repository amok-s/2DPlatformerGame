extends Node

@onready var tap_sound = $TapSound
@onready var menu_music = $MenuMusic
@onready var bg_elements = $bg_elements

var center : Vector2 
@onready var background = $Background

@onready var title_text = $TitleBox/TitleText
@onready var v_box_container = $Menu/MenuBox/VBoxContainer


func godot_bug_fix(text):
	text = text.c_escape()
	text = text.replace("\\r\\n", "\n")
	text = text.c_unescape()
	return text

func _ready():
	GlobalLevelManager.music_time = 0
	menu_music.play(0.5)
	center = Vector2(10, 20)
	
	
	title_text.text = godot_bug_fix(title_text.text)
	for i in v_box_container.get_children():
		i.text = godot_bug_fix(i.text)

	
	
func _process(delta):
	var tween = bg_elements.create_tween()
	
	var offset = center - bg_elements.get_global_mouse_position() * 0.05
	
	tween.tween_property(bg_elements, "position", offset, 1.0)

func _on_menu_music_finished():
	menu_music.play(0.3)

func _on_level_1_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		get_tree().change_scene_to_file("res://scenes/levels/level1_1.tscn")

func _on_level_2_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		get_tree().change_scene_to_file("res://scenes/levels/level1_11.tscn")
		
func _on_level_3_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		get_tree().change_scene_to_file("res://scenes/levels/test_level_2.tscn")		


func _on_play_button_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		get_tree().change_scene_to_file("res://scenes/levels/level_1_0.tscn")



func _on_quit_pressed():
	get_tree().quit() 
