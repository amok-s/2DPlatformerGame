extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var marker_node : Node

var scale_switch = false

func _ready():
	pass

func _physics_process(delta):
	if velocity.x > 0 && !scale_switch:
		scale_switch = true
		$sprite.scale.x = -$sprite.scale.x
		
	if velocity.x < 0 && scale_switch:
		scale_switch = false
		$sprite.scale.x = -$sprite.scale.x
		
	move_and_slide()
	


