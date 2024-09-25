extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalLevelManager.startLevelMusic($BgMusic)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_bg_music_finished():
	GlobalLevelManager.music_time = 0
	GlobalLevelManager.startLevelMusic($BgMusic)
