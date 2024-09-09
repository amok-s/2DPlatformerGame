extends State
class_name ChameleonTakingDamage

@export var character: CharacterBody2D
@export var sprite = AnimatedSprite2D

func Enter():
	sprite.animation = "hit"
	get_node("../../BodyCollision").queue_free()
	var random_x = randf_range(-150, 150)
	character.velocity.x = random_x
	character.velocity.y = -190
	
func Exit():
	pass
	
func Update(_delta:float):
	pass
