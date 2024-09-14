extends Node

var music_time = 0

func startLevelMusic(levelMusic):
	if levelMusic:
		var levelMusicVolume = levelMusic.volume_db
		levelMusic.volume_db = -60
		levelMusic.play(music_time + 0.65 if music_time > 0 else 0)
		var tween = get_tree().create_tween()
		tween.tween_property(levelMusic, "volume_db", levelMusicVolume, 1.3)

