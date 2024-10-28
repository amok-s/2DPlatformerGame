extends Node
class_name level2_2

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalLevelManager.startLevelMusic($BgMusic)
	GlobalLevelManager.endOfArc = true
	GlobalLevelManager.currentArc = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_bg_music_finished():
	GlobalLevelManager.music_time = 0
	GlobalLevelManager.startLevelMusic($BgMusic)
