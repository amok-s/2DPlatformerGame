extends Node
@onready var pause_panel = $PausePanel
@onready var bgMusic = $"../../BgMusic"

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_panel.hide()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var esc_pressed = Input.is_action_just_pressed("escape")
	if (esc_pressed == true):
		pause_panel.show()
		$PausePanel/VBoxContainer/Resume.grab_focus()
		bgMusic.volume_db = bgMusic.volume_db - 15
		get_tree().paused = true




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
	var bgMusicVolume = bgMusic.volume_db
	var tween = get_tree().create_tween()
	tween.tween_property(bgMusic, "volume_db", bgMusicVolume + 15, 0.6)
	get_tree().paused = false
	
