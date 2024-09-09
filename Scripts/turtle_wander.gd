extends State
class_name TurtleWander


@export var character : CharacterBody2D
@onready var sprite = $"../../sprite"
@onready var floor_detector = $"../../Detectors/FloorDetector"
@onready var wall_detector = $"../../Detectors/WallDetector"



var can_stop = false

func Enter():
	print("wander")
	can_stop = false
	choose_direction()
	wander_time()
	
func Exit():
	character.velocity.x = 0
	character.go_left = false
	character.go_right = false
	can_stop = false
	
func Update(_delta:float):
	if (character.startled == true):
		state_transition.emit(self, "Startled")
	
	if (can_stop == true):
		state_transition.emit(self, "Idle")

func choose_direction():
	if floor_detector.is_colliding() == false or wall_detector.is_colliding():
		if character.facing_right == true:
			character.scale.x = -2
			character.go_left = true
			character.facing_right = false
			
		elif character.facing_right == false:
			character.scale.x = -2
			character.go_right = true
			character.facing_right = true
			
	else:
		var random_direction = randi_range(1, 2)
		if random_direction == 1: 
			if (character.facing_right == false):
				character.scale.x = -2
			character.go_right = true
			character.facing_right = true
			
		else:
			if (character.facing_right == true):
				character.scale.x = -2
			character.go_left = true
			character.facing_right = false

func wander_time():
	await get_tree().create_timer(randf_range(2.8, 4.0)).timeout
	can_stop = true
