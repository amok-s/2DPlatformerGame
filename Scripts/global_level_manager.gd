extends Node

var music_time = 0
var nextLevelPath: String
var currentArc = 0
var pausable = false
var death_count = 0
var currentMusicPath
var endOfArc = false

func startLevelMusic(levelMusic):
	if levelMusic:
		var levelMusicVolume = levelMusic.volume_db
		levelMusic.volume_db = -60
		if !currentMusicPath:
			levelMusic.play(0)
		elif levelMusic.stream.resource_path != currentMusicPath:
			levelMusic.play(0)
		else:
			levelMusic.play(music_time + 0.65 if music_time > 0 else 0)
		currentMusicPath = levelMusic.stream.resource_path
		var tween = get_tree().create_tween()
		tween.tween_property(levelMusic, "volume_db", levelMusicVolume, 1.3)



