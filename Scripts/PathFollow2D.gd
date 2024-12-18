extends PathFollow2D

@export var speed : float
@export var opposite_direction : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	pass
	
func _process(delta):
	if !opposite_direction:
		progress += delta * speed
	else:
		progress -= delta * speed
