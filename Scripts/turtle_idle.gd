extends State
class_name TurtleIdle

@export var character : CharacterBody2D
@onready var sprite = $"../../sprite"
@onready var animation_player = $"../../AnimationPlayer"



var can_go = false

func Enter():
	can_go = false
	if character.spikes_out == false:
		sprite.animation = "idle"
	else:
		sprite.animation = "idle_spikes"
		character.spike_counter += 1
		if character.spike_counter == 4:
			spikes_in()
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

func spikes_in():
	character.spikes_out = false
	sprite.animation = "spikes_in"
	animation_player.play_backwards("spikes_out")
	await get_tree().create_timer(0.5).timeout
	sprite.animation = "idle"
	character.spike_counter = 0
