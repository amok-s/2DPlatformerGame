extends Node

var lvlname : String = "lvl1_2"

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalLevelManager.startLevelMusic($BgMusic)
	GlobalLevelManager.currentArc = 1
	GlobalLevelManager.endOfArc = true


func _on_bg_music_finished():
	GlobalLevelManager.music_time = 0
	GlobalLevelManager.startLevelMusic($BgMusic)
