extends State
class_name BeeIdle

@export var character : CharacterBody2D
@onready var animation_player = $"../../AnimationPlayer"
@onready var bee = $"../../.."
@onready var sprite = $"../../sprite"


func Enter():
	sprite.animation = "idle"
	if bee.side_sways == false:
		animation_player.play("bobing")
	else:
		animation_player.play("side_sways")
	
func Exit():
	pass
	
func Update(_delta:float):
	if character.taking_damage == true:
		state_transition.emit(self, "TakingDamage")
	
	if character.player_spotted == true:
		state_transition.emit(self, "Attack")
		
	
