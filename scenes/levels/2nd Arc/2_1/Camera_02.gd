extends Area2D

var originalCameraZoom : Vector2 = Vector2(1.455, 1.455)

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		$"..".cameraChangeOffset(Vector2(0, 70), 2.3)


func _on_body_exited(body):
	if body.name == "CharacterBody2D":
		$"..".cameraChangeOffset(Vector2(0, 0), 3)
