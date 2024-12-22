extends Node

@onready var tap_sound = $TapSound
@onready var menu_music = $MenuMusic
@onready var bg_elements = $bg_elements
@onready var master_volume = $Menu/OptionsMenu/Options/VBoxContainer/MasterVolume
@onready var music_volume = $Menu/OptionsMenu/Options/VBoxContainer/MusicVolume


var center : Vector2 
@onready var background = $Background

@onready var title_text = $TitleBox/TitleText
@onready var v_box_container = $Menu/MenuBox/MainMenu
var inputs : Array[String]

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
	
	if Input.is_action_just_pressed("escape"):
		esc_pressed()
		



func _on_menu_music_finished():
	menu_music.play(0.3)

func _on_play_button_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		if Stats.levels_unlocked.is_empty():
			GlobalLevelManager.currentArc = 1
			GlobalLevelManager.nextLevelPath = "res://scenes/levels/1st Arc/1_0/level_1_0.tscn"
			var loadingScreen = load("res://scenes/loading_screen.tscn")
			get_tree().change_scene_to_packed(loadingScreen)
		else:
			$Menu/MenuBox.hide()
			$Menu/LevelSelection.show()
			$Menu/LevelSelection.level_selection()


func _on_quit_pressed():
	get_tree().quit() 

func _on_options_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		$Menu/MenuBox.hide()
		$TitleBox.hide()
		$Menu/OptionsMenu.show()
		$Menu/OptionsMenu/Options/VBoxContainer/MasterVolume.grab_focus()

func _on_back_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		$Menu/MenuBox.show()
		$TitleBox.show()
		$Menu/OptionsMenu.hide()
		music_volume.value = AudioServer.get_bus_volume_db(1)
		master_volume.value = AudioServer.get_bus_volume_db(0)
		Stats.current_options["music volume"] = music_volume.value
		Stats.current_options["master volume"] = master_volume.value
		Stats.current_options["full screen"] = $Menu/OptionsMenu/Options/VBoxContainer/FullScreen.button_pressed
		$Menu/MenuBox/MainMenu/Play.grab_focus()

func esc_pressed():
	if $Menu/OptionsMenu.is_visible_in_tree():
		music_volume.value = Stats.current_options["music volume"]
		AudioServer.set_bus_volume_db(1, music_volume.value)
		
		master_volume.value = Stats.current_options["master volume"]
		AudioServer.set_bus_volume_db(0, master_volume.value)
		
		if Stats.current_options["full screen"] == true:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			$Menu/OptionsMenu/Options/VBoxContainer/FullScreen.button_pressed = true
		elif Stats.current_options["full screen"] == false:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			$Menu/OptionsMenu/Options/VBoxContainer/FullScreen.button_pressed = false
		
	$Menu/OptionsMenu.hide()
	$Menu/LevelSelection.hide()
	$TitleBox.show()
	$Menu/MenuBox.show()
	$Menu/MenuBox/MainMenu/Play.grab_focus()

func konami_code(action):
	if inputs.size() < 8:
		inputs.push_front(action)
	elif inputs.size() == 8:
		inputs.remove_at(7)
		inputs.push_front(action)
	if inputs == ["right", "left", "right", "left", "down", "down", "up", "up"]:
		$Unlock.play(0)
		$Menu/LevelSelection.unlock_all_levels()
		
func _unhandled_input(event):
	if event.is_action("left") and event.is_released():
		konami_code("left")
	if event.is_action("right") and event.is_released():
		konami_code("right")
	if event.is_action("ui_up") and event.is_released():
		konami_code("up")
	if event.is_action("ui_down") and event.is_released():
		konami_code("down")


