extends AnimatedSprite2D

var scale_switch = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().velocity.x < 0 and scale_switch == false:
		scale.x = -scale.x
		scale_switch = true
	
	if get_parent().velocity.x > 0 and scale_switch == true:
		scale.x = - scale.x
		scale_switch = false
	
