extends Node

var lvlname : String = "lvl2_0"

func _ready():
	GlobalLevelManager.startLevelMusic($BgMusic, true)
	GlobalLevelManager.endOfArc = false
	GlobalLevelManager.currentArc = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_bg_music_finished():
	GlobalLevelManager.music_time = 0
	GlobalLevelManager.startLevelMusic($BgMusic)
