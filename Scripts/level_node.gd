extends Node

@export var lvlname : String = "lvl"
@export var show_text_sfx = true
@export var fruits_left_to_show_sfx : int = 8
@export var current_arc : int
@export var end_of_arc : bool = false
@export var intro : bool = false

func _ready():
	GlobalLevelManager.startLevelMusic($BgMusic)
	GlobalLevelManager.currentArc = current_arc
	GlobalLevelManager.endOfArc = end_of_arc
	if intro == true:
		$UI/CoinsPanel.hide()
		$UI/HeartsPanel.hide()
		

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		SceneTransition.level_restart()

func _on_bg_music_finished():
	GlobalLevelManager.music_time = 0
	GlobalLevelManager.startLevelMusic($BgMusic)

