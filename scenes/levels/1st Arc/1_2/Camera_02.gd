extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", camEntered)
	connect("body_exited", camExited)

func camEntered(body):
	if body.name == "CharacterBody2D":
		get_parent().cameraChangeZoom(Vector2(1.3, 1.3), 1.3)
		get_parent().cameraChangeOffset(Vector2(0, 120), 1.5)

func camExited(body):
	if body.name == "CharacterBody2D":
		get_parent().cameraChangeZoom(get_parent().originalZoom, 0.8)
		get_parent().cameraChangeOffset(Vector2(0, 0), 0.5)
