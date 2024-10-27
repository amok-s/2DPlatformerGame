extends CanvasLayer

func change_scene(target: String) -> void:
	$AnimationPlayer.play("pixelate")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene(target)
	$AnimationPlayer.play_backwards("pixelate")
	
func chnage_scene_to_packed():
	pass
