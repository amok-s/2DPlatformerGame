extends State
class_name ChameleonWander

@export var character: CharacterBody2D
@export var sprite = AnimatedSprite2D

@onready var floor_detector = $"../../Detectors/FloorDetector"
@onready var wall_detector = $"../../Detectors/WallDetector"


var can_stop = false

func Enter():
	can_stop = false
	choose_direction()
	wander_time()
	
func Exit():
	character.go_right = false
	character.go_left = false
	can_stop = false
	character.velocity.x = 0
	
func Update(_delta:float):
	if (character.taking_damage == true):
		state_transition.emit(self, "TakingDamage")
	
	if (character.velocity.x > 1 || character.velocity.x < -1):
		sprite.animation = "run"
	else:
		sprite.animation = "idle"
	
	if (can_stop == true || floor_detector.is_colliding() == false):
		state_transition.emit(self, "Idle")

	if (character.player_detected == true):
		state_transition.emit(self, "Attack")

func choose_direction():
	
	if floor_detector.is_colliding() == false or wall_detector.is_colliding():
		if character.scale_switch == true:
			character.scale.x = -2
			character.go_left = true
			character.scale_switch = false
			
		elif character.scale_switch == false:
			character.scale.x = -2
			character.go_right = true
			character.scale_switch = true
			
	else:
		var random_direction = randi_range(1, 2)
		if random_direction == 1: 
			if (character.scale_switch == false):
				character.scale.x = -2
			character.go_right = true
			character.scale_switch = true
			
		else:
			if (character.scale_switch == true):
				character.scale.x = -2
			character.go_left = true
			character.scale_switch = false

	

func wander_time():
	await get_tree().create_timer(randf_range(1.7, 2.8)).timeout
	can_stop = true
