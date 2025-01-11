extends Control

@onready var tap_sound = $"../../../TapSound"


func reset_progress():
	
	$Panel/HBoxContainer/No.grab_focus()
	tap_sound.play()

func _on_yes_pressed():
	tap_sound.play()
	SaveSystem.delete_progress()
	Stats.restart()
	var vignette = $"../../../Vignette/ColorRect".get_material()
	var tween_2 = get_tree().create_tween()
	tween_2.tween_property(vignette, "shader_parameter/outerRadius", 0, 1.4)
	await get_tree().create_timer(1.4).timeout
	get_tree().change_scene_to_file("res://scenes/splash_screen.tscn")
	


func _on_no_pressed():
	hide()
	tap_sound.play()
	$"../Options/VBoxContainer/ResetProgress".grab_focus()
