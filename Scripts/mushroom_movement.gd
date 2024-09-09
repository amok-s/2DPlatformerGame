extends State
class_name MushroomMovement

@export var character : CharacterBody2D
@export var sprite : AnimatedSprite2D

@onready var left_detector = %RayCastFloorLeft
@onready var right_detector = %RayCastFloorRight
@onready var left_wall = $"../../LeftWall"
@onready var right_wall = $"../../RightWall"



var can_stop = false

func Enter():
	sprite.animation = "idle"
	choose_direction()
	movement_timer()
	
func Update(_delta:float):
	if not left_detector.is_colliding() and character.velocity.x < -1:
		character.velocity.x = 0
		character.go_left = false
	
	if not right_detector.is_colliding() and character.velocity.x > 1:
		character.velocity.x = 0
		character.go_right = false
	
	if (character.velocity.x > 1 || character.velocity.x < -1):
			sprite.animation = "run"
	else:
		sprite.animation = "idle"

	if (character.being_hit == true):
		state_transition.emit(self, "TakingDamage")
		
	if(can_stop == true):
		state_transition.emit(self, "Idle")
		
	

func Exit():
	character.velocity.x = 0
	character.go_left = false
	character.go_right = false
	can_stop = false

func movement_timer():
	await get_tree().create_timer(randf_range(1.5, 2.4)).timeout
	can_stop = true

func choose_direction():
	
	if left_detector.is_colliding() == false || left_wall.is_colliding():
		character.go_right = true
	
	elif right_detector.is_colliding() == false || right_wall.is_colliding():
		character.go_left = true
		
	else:
		var random_direction = randi_range(1, 2)
		if random_direction == 1: 
			character.go_right = true
		else:
			character.go_left = true

