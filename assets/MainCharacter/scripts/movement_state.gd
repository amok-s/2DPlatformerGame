extends State
class_name PlayerMovement

@export var player : CharacterBody2D
@export var sprite : AnimatedSprite2D


#state_transition.emit(self, "attacking"


# Called when the node enters the scene tree for the first time.
func Enter():
	print(self.name)
	sprite.animation = "default" 

func Update(_delta:float):
	if (player.taking_damage == true):
		state_transition.emit(self, "TakingDamage")
	if player.is_on_floor():
		if (player.velocity.x > 1 || player.velocity.x < -1):
			sprite.animation = "run"
			get_node("../../GrassParticles").emitting = true
			if (player.velocity.x > 1):
				get_node("../../GrassParticles").scale.x = -0.3
				get_node("../../GrassParticles").position.x = -16
			if (player.velocity.x < -1):
				get_node("../../GrassParticles").scale.x = 0.3
				get_node("../../GrassParticles").position.x = 16
		else:
			sprite.animation = "default"
			get_node("../../GrassParticles").emitting = false

	
	if not player.is_on_floor():
		if (player.velocity.y < 0):
			sprite.animation = "jump"
		elif (player.velocity.y > 0):
			sprite.animation = "fall"
			
	
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "Jump")
		



func Exit():
	get_node("../../GrassParticles").emitting = false
	pass
