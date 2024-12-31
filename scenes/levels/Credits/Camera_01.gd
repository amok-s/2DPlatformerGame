extends Area2D

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		get_parent().cameraChangeZoom(Vector2(1, 1), 1.4)
