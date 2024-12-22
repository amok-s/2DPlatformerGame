extends AnimatedSprite2D

var scale_switch = false
@onready var collision_shape = $"../CollisionShape2D"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if get_parent().velocity.x < 0 and scale_switch == false:
		scale.x = -scale.x
		collision_shape.scale.x = -collision_shape.scale.x
		scale_switch = true
	
	if get_parent().velocity.x > 0 and scale_switch == true:
		scale.x = - scale.x
		collision_shape.scale.x = -collision_shape.scale.x
		scale_switch = false
	
func outlineBlink():
	var originalValue = get_material().get_shader_parameter("color")
	get_material().set_shader_parameter("color", Color(1, 1, 0.812, 0.965))
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_value, Color(1, 1, 0.812, 0.965), originalValue, 0.6)


# tween value automatically gets passed into this function
func set_shader_value(value: Color):
	# in my case i'm tweening a shader on a texture rect, but you can use anything with a material on it
	self.material.set_shader_parameter("color", value);
	#Color(0.89, 0.525, 0.776, 0.976)
