extends State
class_name ChameleonWander

@export var character: CharacterBody2D
@export var sprite = AnimatedSprite2D

var can_stop = false

func Enter():
	can_stop = false
	print("wander state")
	print("skala wchodzi: " + str(character.scale.x))
	choose_direction()
	wander_time()
	
func Exit():
	character.go_right = false
	can_stop = false
	character.go_left = false
	character.velocity.x = 0
	print("skala wychodzi: " + str(character.scale.x))
	
func Update(_delta:float):
	if (character.taking_damage == true):
		state_transition.emit(self, "TakingDamage")
	
	if (character.velocity.x > 1 || character.velocity.x < -1):
		sprite.animation = "run"
	else:
		sprite.animation = "idle"
	
	if (can_stop == true):
		state_transition.emit(self, "Idle")

	if (character.player_detected == true):
		state_transition.emit(self, "Attack")
func choose_direction():
	#if left_detector.is_colliding() && right_detector.is_colliding():
	var random_direction = randi_range(1, 2)
	if random_direction == 1: 
		if (character.scale_switch == false):
			character.scale.x = -2
		print("chce w prawo")
		character.go_right = true
		character.scale_switch = true
		
	else:
		if (character.scale_switch == true):
			character.scale.x = -2
		print("chce w lewo")
		character.go_left = true
		character.scale_switch = false

	#if not left_detector.is_colliding():
		#character.go_right = true
	#
	#if not right_detector.is_colliding():
		#character.go_left = true

func wander_time():
	await get_tree().create_timer(randf_range(1.7, 2.8)).timeout
	can_stop = true
