extends State
class_name MushroomIdle

@export var character : CharacterBody2D
@export var sprite : AnimatedSprite2D

var can_go = false

func Enter():
	print("grzyb stoi")
	sprite.animation = "idle"
	idle_timer()
	
func Update(_delta:float):
	if character.being_hit == true:
		state_transition.emit(self, "TakingDamage")
		
	if can_go == true:
		state_transition.emit(self, "Movement")

func Exit():
	can_go = false
	
func idle_timer():
	await get_tree().create_timer(randf_range(1.8, 2.8)).timeout
	can_go = true
	
	
	
