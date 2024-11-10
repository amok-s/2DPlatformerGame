extends Node

var lvlname : String = "lvl2_2"

func _ready():
	GlobalLevelManager.startLevelMusic($BgMusic)
	GlobalLevelManager.currentArc = 2
	GlobalLevelManager.endOfArc = true


func _on_bg_music_finished():
	GlobalLevelManager.music_time = 0
	GlobalLevelManager.startLevelMusic($BgMusic)
