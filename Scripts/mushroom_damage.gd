extends State
class_name MushroomDamage

@export var character : CharacterBody2D
@export var sprite : AnimatedSprite2D

func Enter():
	sprite.play("hit")
	var random_x = randf_range(-150, 150)
	character.velocity.x = random_x
	character.velocity.y = -220
	
func Exit():
	pass
	
func Update(_delta:float):
	pass
