extends State
class_name BatSleeping

@onready var sprite = $"../../sprite"

var player_spotted : bool = true

func Enter():
	$"../../DetectionArea".connect("body_entered", BodySpotted)

func Exit():
	player_spotted = true
	
func Update(_delta:float):
	pass
	
func BodySpotted(body):
	if body.name == "CharacterBody2D":
		if player_spotted:
			player_spotted = false
			state_transition.emit(self, "Flying")
