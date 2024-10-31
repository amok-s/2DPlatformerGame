extends Node
@onready var pause_panel = $PausePanel
@onready var bgMusic = $"../../BgMusic"
@onready var ui = $"../CoinsPanel"
@onready var player = $"../../Scene Objects/CharacterBody2D"
@onready var death_count = $PausePanel/Node2D/DeathCount
@onready var music_volume = $OptionsPanel/VBoxContainer/MusicVolume



var zoom_protect = 0
var original_cam

func _ready():
	pause_panel.hide()
	$CanvasLayer.hide()
	$OptionsPanel.hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var esc_pressed = Input.is_action_just_pressed("escape")
	if (esc_pressed == true and GlobalLevelManager.pausable == true):
		GlobalLevelManager.pausable = false
		camera_zoom_in()
		$CanvasLayer.show()
	death_count.text = "today's death count : " + str(GlobalLevelManager.death_count)
		




func _on_resume_pressed():
	playTapSound()
	unpause()


func _on_main_menu_pressed():
	playTapSound()
	await get_tree().create_timer(0.25).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_restart_pressed():
	playTapSound()
	await get_tree().create_timer(0.25).timeout
	pause_panel.hide()
	get_tree().paused = false
	SceneTransition.level_restart()

func unpause():
	pause_panel.hide()
	$CanvasLayer.hide()
	ui.show()
	var bgMusicVolume = bgMusic.volume_db
	var tween = get_tree().create_tween()
	tween.tween_property(bgMusic, "volume_db", bgMusicVolume + 12, 0.6)
	get_tree().paused = false
	
	var cam_tween = get_tree().create_tween()
	cam_tween.set_parallel()
	cam_tween.tween_property(%Camera2D, "zoom", original_cam, 0.4)
	cam_tween.tween_callback(change_esc_bool).set_delay(0.4)
	
	
func change_esc_bool():
	GlobalLevelManager.pausable = true
	
func camera_zoom_in():
	var tween = get_tree().create_tween()
	original_cam = %Camera2D.zoom
	tween.set_parallel()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(%Camera2D, "zoom", Vector2(3.6, 3.6), 0.2)
	tween.tween_callback(pause).set_delay(0.1)

func pause():
	pause_panel.show()
	ui.hide()
	$PausePanel/VBoxContainer/Resume.grab_focus()
	bgMusic.volume_db = bgMusic.volume_db - 12
	get_tree().paused = true

func _on_options_pressed():
	playTapSound()
	$OptionsPanel.show()
	$OptionsPanel/VBoxContainer/MasterVolume.grab_focus()
	


func _on_back_pressed():
	playTapSound()
	$OptionsPanel.hide()
	var bgMusicVolume = bgMusic.volume_db
	var tween = get_tree().create_tween()
	tween.tween_property(bgMusic, "volume_db", bgMusicVolume - 12, 0.6)
	$PausePanel/VBoxContainer/Options.grab_focus()


func playTapSound():
	$TapSound.play(0)
