extends Node2D

var originalCameraZoom : Vector2 = Vector2(1.455, 1.455)
var tweenZoom
var tweenOffset 

func _ready():
	tweenZoom = get_tree().create_tween()

func _on_camera_01_body_entered(body):
	if body.name == "CharacterBody2D":
		cameraChangeZoom(Vector2(1.15, 1.15))
		cameraChangeOffset(Vector2(0, -75))

func _on_camera_01_body_exited(body):
	if body.name == "CharacterBody2D":
		cameraChangeZoom(originalCameraZoom)
		cameraChangeOffset(Vector2(0, 0))


func cameraChange(zoomValue : Vector2 = Vector2(0, 0), offset : Vector2 = Vector2(0, 0), time : float = 3):
	
	
	var tweenZoom = get_tree().create_tween()
	var zoomChange = originalCameraZoom + zoomValue
	tweenZoom.tween_property(%Camera2D, "zoom", zoomChange, time)
	
	var tweenOffset = get_tree().create_tween()
	tweenOffset.tween_property(%Camera2D, "offset", offset, time)

func cameraChangeZoom(zoomValue : Vector2, time : float = 3):
	if tweenZoom.is_valid():
		tweenZoom.kill()
		tweenZoom = get_tree().create_tween()
		tweenZoom.tween_property(%Camera2D, "zoom", zoomValue, time)
	else:
		tweenZoom = get_tree().create_tween()
		tweenZoom.set_parallel()
		tweenZoom.set_ease(Tween.EASE_IN_OUT)
		tweenZoom.tween_property(%Camera2D, "zoom", zoomValue, time)

		

func cameraChangeOffset(offsetValue : Vector2, time : float = 3):
	if tweenOffset:
		tweenOffset.kill()
	tweenOffset = create_tween()
	tweenOffset.set_trans(Tween.TRANS_SINE)
	tweenOffset.set_ease(Tween.EASE_IN_OUT)
	tweenOffset.tween_property(%Camera2D, "offset", offsetValue, time)
