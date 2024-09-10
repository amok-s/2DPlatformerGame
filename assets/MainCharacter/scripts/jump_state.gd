extends State
class_name PlayerJump

@export var player : CharacterBody2D
@export var sprite : AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func Enter():
	sprite.animation = "jump"
	pass # Replace with function body.

func Update(_delta:float):
	
	if (player.velocity.y > 0) and (player.jump_count == 0):
			sprite.animation = "fall"
	else:
		if (player.jump_count == 1):
			sprite.animation = "jump"
		if (player.jump_count == 2):
			sprite.play("double_jump")
		if (player.velocity.y > 0) and (player.jump_count == 1):
			sprite.animation = "fall"
	
	if player.is_on_floor():
		state_transition.emit(self, "Movement")
		
	if (player.taking_damage == true):
		state_transition.emit(self, "TakingDamage")

func Exit():
	pass
