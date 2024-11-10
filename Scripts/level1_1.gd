extends Node

var lvlname : String = "lvl1_1"
@export var show_text_sfx = true
@export var fruits_left_to_show_sfx : int = 5

func _ready():
	GlobalLevelManager.startLevelMusic($BgMusic)
	GlobalLevelManager.currentArc = 3
	GlobalLevelManager.endOfArc = false

func _on_bg_music_finished():
	GlobalLevelManager.music_time = 0
	GlobalLevelManager.startLevelMusic($BgMusic)

