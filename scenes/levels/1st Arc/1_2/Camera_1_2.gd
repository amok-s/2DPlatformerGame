extends Area2D

var originalCameraZoom : Vector2 = Vector2(1.455, 1.455)

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		$"..".cameraChangeZoom(Vector2(1.15, 1.15))
		$"..".cameraChangeOffset(Vector2(0, -75))


func _on_body_exited(body):
	if body.name == "CharacterBody2D":
		$"..".cameraChangeZoom(originalCameraZoom)
		$"..".cameraChangeOffset(Vector2(0, 0))
