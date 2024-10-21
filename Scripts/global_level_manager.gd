extends Node

var music_time = 0
var nextLevelPath: String
var currentArc = 0
var endOfArc = false
var pausable = false
var death_count = 0


func startLevelMusic(levelMusic, newArc = false):
	if levelMusic:
		var levelMusicVolume = levelMusic.volume_db
		levelMusic.volume_db = -60
		if newArc == true:
			levelMusic.play(0)
		else:
			levelMusic.play(music_time + 0.65 if music_time > 0 else 0)
		var tween = get_tree().create_tween()
		tween.tween_property(levelMusic, "volume_db", levelMusicVolume, 1.3)

func LevelStart():
	pass
