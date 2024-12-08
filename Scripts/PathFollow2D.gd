extends PathFollow2D

@export var speed : float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	pass
	
func _process(delta):
	progress += delta * speed
