extends CanvasLayer

func change_scene(target: PackedScene) -> void:
	$AnimationPlayer.play("pixelate")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(target)
	$AnimationPlayer.play_backwards("pixelate")
	
func level_restart() -> void:
	$AnimationPlayer.play("pixelate")
	await $AnimationPlayer.animation_finished
	get_tree().reload_current_scene()
	$AnimationPlayer.play_backwards("pixelate")
