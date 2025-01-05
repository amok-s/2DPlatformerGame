extends Control

func _ready():
	hide()

func _on_yes_pressed():
	$"../../TapSound".play(0)
	$"../..".can_esc = false
	hide()
	var vignette = $"../../Vignette/ColorRect".get_material()
	var tween = get_tree().create_tween()
	tween.tween_property(vignette, "shader_parameter/MainAlpha", 1, 1.3)
	var tween_2 = get_tree().create_tween()
	tween_2.tween_property(vignette, "shader_parameter/outerRadius", 0, 1.4)
	await get_tree().create_timer(1.3).timeout
	get_tree().quit() 

func _on_no_pressed():
	$"../../TapSound".play(0)
	hide()
	$"../MenuBox".show()
	$"../../TitleBox".show()
	$"../MenuBox/MainMenu/Play".grab_focus()
