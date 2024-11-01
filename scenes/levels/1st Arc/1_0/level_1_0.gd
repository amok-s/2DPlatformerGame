extends Node

var lvlname : String = "lvl1_0"

func _ready():
	GlobalLevelManager.startLevelMusic($BgMusic)
	GlobalLevelManager.currentArc = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_bg_music_finished():
	GlobalLevelManager.music_time = 0
	GlobalLevelManager.startLevelMusic($BgMusic)
