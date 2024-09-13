extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("pojawia sie sfx")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_animation(name):
	play(name)


func _on_animation_finished():
	queue_free()
