extends Node
@onready var pause_panel = $PausePanel


# Called when the node enters the scene tree for the first time.
func _ready():
	pause_panel.hide()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var esc_pressed = Input.is_action_just_pressed("escape")
	if (esc_pressed == true):
		get_tree().paused = true
		pause_panel.show()
		$PausePanel/VBoxContainer/Resume.grab_focus()



func _on_resume_pressed():
	pause_panel.hide()
	get_tree().paused = false


func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_restart_pressed():
	pause_panel.hide()
	get_tree().paused = false
	get_tree().reload_current_scene()
