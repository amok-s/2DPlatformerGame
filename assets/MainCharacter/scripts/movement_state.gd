extends State
class_name PlayerMovement

@export var player : CharacterBody2D
@export var sprite : AnimatedSprite2D


#state_transition.emit(self, "attacking"


# Called when the node enters the scene tree for the first time.
func Enter():
	pass

func Update(_delta:float):
	
	
	if player.is_on_floor():
		if (player.velocity.x > 1 || player.velocity.x < -1):
			sprite.animation = "run"
		else:
			sprite.animation = "default"
		
			
	
	if not player.is_on_floor():
		if (player.velocity.y < 0):
			sprite.animation = "jump"
		elif (player.velocity.y > 0):
			sprite.animation = "fall"
			
	
	
	
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "Jump")
		
	if (player.taking_damage == true):
		state_transition.emit(self, "TakingDamage")


func Exit():
	pass
