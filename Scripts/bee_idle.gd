extends State
class_name BeeIdle


@onready var animation_player = $"../../AnimationPlayer"
@onready var bee = $"../.."
@onready var sprite = $"../../sprite"




func Enter():
	sprite.animation = "idle"
	if bee.get_parent().name == "PathFollow2D":
		bee.path = bee.get_parent()
	
func Exit():
	pass
	
func Update(_delta:float):
	if bee.taking_damage == true:
		state_transition.emit(self, "TakingDamage")

	if bee.player_spotted == true:
		state_transition.emit(self, "Attack")
	
	if bee.path:
		bee.path.progress += _delta * bee.speed
		
	
