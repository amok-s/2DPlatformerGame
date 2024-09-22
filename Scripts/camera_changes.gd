extends Node2D

var tweenZoom
var tweenOffset 

func _ready():
	tweenZoom = get_tree().create_tween()

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
