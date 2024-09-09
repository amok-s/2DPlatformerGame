extends State
class_name TurtleIdle

@export var character : CharacterBody2D
@onready var sprite = $"../../sprite"


var can_go = false

func Enter():
	print("idle")
	can_go = false
	idle_timer()
	
func Exit():
	pass
	
func Update(_delta:float):
	if (character.startled == true):
		state_transition.emit(self, "Startled")
	
	if (can_go == true):
		state_transition.emit(self, "Wander")

func idle_timer():
	await get_tree().create_timer(randf_range(3.6, 5.3)).timeout
	can_go = true
