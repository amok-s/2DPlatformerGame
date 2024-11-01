extends Node

var lvlname : String = "lvl3_0"

func _ready():
	GlobalLevelManager.startLevelMusic($BgMusic)
	GlobalLevelManager.currentArc = 3




func _on_bg_music_finished():
	GlobalLevelManager.music_time = 0
	GlobalLevelManager.startLevelMusic($BgMusic)
