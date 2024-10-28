extends Panel

@onready var master_volume = $VBoxContainer/MasterVolume
@onready var music_volume = $VBoxContainer/MusicVolume


func _on_master_volume_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)

func _on_default_pressed():
	master_volume.value = 2
	music_volume.value = 0
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	$VBoxContainer/FullScreen.button_pressed = false



func _on_music_volume_value_changed(value):
	AudioServer.set_bus_volume_db(1, value)




func _on_full_screen_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
