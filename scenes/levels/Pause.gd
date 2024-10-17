extends Node
@onready var pause_panel = $PausePanel
@onready var bgMusic = $"../../BgMusic"
@onready var ui = $"../CoinsPanel"


var original_cam
# Called when the node enters the scene tree for the first time.
func _ready():
	pause_panel.hide()
	$CanvasLayer.hide()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var esc_pressed = Input.is_action_just_pressed("escape")
	if (esc_pressed == true):
		camera_zoom_in()
		$CanvasLayer.show()




func _on_resume_pressed():
	unpause()


func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_restart_pressed():
	pause_panel.hide()
	get_tree().paused = false
	get_tree().reload_current_scene()

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
	
func camera_zoom_in():
	var tween = get_tree().create_tween()
	original_cam = %Camera2D.zoom
	tween.set_parallel()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(%Camera2D, "zoom", Vector2(3.4, 3.4), 0.2)
	tween.tween_callback(pause).set_delay(0.1)

func pause():
	pause_panel.show()
	#ui.hide()
	$PausePanel/VBoxContainer/Resume.grab_focus()
	bgMusic.volume_db = bgMusic.volume_db - 12
	get_tree().paused = true
