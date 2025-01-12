extends Area2D

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		GlobalLevelManager.pausable = false
		queue_free()
		get_parent().cameraChangeZoom(Vector2(1, 1), 1.4)
		$"../../TextShowing/MagicWall/CollisionShape2D3".position += Vector2(0, 500)
