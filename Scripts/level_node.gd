extends Node

@export var lvlname : String = "lvl"
@export var show_text_sfx = true
@export var fruits_left_to_show_sfx : int = 8
@export var current_arc : int
@export var end_of_arc : bool = false

func _ready():
	GlobalLevelManager.startLevelMusic($BgMusic)
	GlobalLevelManager.currentArc = current_arc
	GlobalLevelManager.endOfArc = end_of_arc

func _on_bg_music_finished():
	GlobalLevelManager.music_time = 0
	GlobalLevelManager.startLevelMusic($BgMusic)

