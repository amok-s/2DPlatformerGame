extends AnimatedSprite2D

func play_animation(anim_name):
	play(anim_name)


func _on_animation_finished():
	queue_free()
