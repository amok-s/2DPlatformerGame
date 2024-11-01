extends Node

var lvlname : String = "lvl2_1"

func _ready():
	GlobalLevelManager.startLevelMusic($BgMusic)
	GlobalLevelManager.endOfArc = false
	GlobalLevelManager.currentArc = 1


func _on_bg_music_finished():
	GlobalLevelManager.music_time = 0
	GlobalLevelManager.startLevelMusic($BgMusic)
