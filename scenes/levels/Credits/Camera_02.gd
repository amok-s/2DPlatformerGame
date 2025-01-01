extends Area2D

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		get_parent().cameraChangeZoom(Vector2(1.3, 1.3), 1.6)
		get_parent().cameraChangeOffset(Vector2(0, -30), 1)
		queue_free()
