extends State
class_name ChameleonIdle

@export var character: CharacterBody2D
@export var sprite = AnimatedSprite2D

var can_go = false


func Enter():
	can_go = false
	sprite.animation = "idle"
	idle_timer()
	pass
	
func Update(_delta:float):
	if (character.taking_damage == true):
		state_transition.emit(self, "TakingDamage")
	
	if (character.player_detected == true):
		state_transition.emit(self, "Attack")
		
	if (can_go == true):
		state_transition.emit(self, "Wander")
	

		
	
func Exit():
	can_go = false

func idle_timer():
	await get_tree().create_timer(randf_range(2.6, 3.5)).timeout
	can_go = true
