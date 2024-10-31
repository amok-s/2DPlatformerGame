extends Panel

@onready var master_volume = $VBoxContainer/MasterVolume
@onready var music_volume = $VBoxContainer/MusicVolume
@onready var full_screen = $VBoxContainer/FullScreen


func _ready():
	music_volume.value = AudioServer.get_bus_volume_db(1)
	master_volume.value = AudioServer.get_bus_volume_db(0)
	if DisplayServer.window_get_mode() == 0:
		full_screen.button_pressed = false
	if DisplayServer.window_get_mode() == 4:
		full_screen.button_pressed = true
	

func _on_master_volume_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)
	master_volume.value = AudioServer.get_bus_volume_db(0)

func _on_default_pressed():
	master_volume.value = 0
	music_volume.value = 0
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	$VBoxContainer/FullScreen.button_pressed = false

func _on_music_volume_value_changed(value):
	AudioServer.set_bus_volume_db(1, value)
	music_volume.value = AudioServer.get_bus_volume_db(1)


func _on_full_screen_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
