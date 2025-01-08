extends Area2D


func _ready():
	connect("body_entered", camEntered)
	connect("body_exited", camExited)


func camEntered(body):
	if body.name == "CharacterBody2D":
		get_parent().cameraChangeZoom(Vector2(1, 1), 0.6)
		get_parent().cameraChangeOffset(Vector2(0, 250), 0.8)

func camExited(body):
	if body.name == "CharacterBody2D":
		get_parent().cameraChangeZoom(get_parent().originalZoom, 0.8)
		get_parent().cameraChangeOffset(Vector2(0, 0), 0.5)
