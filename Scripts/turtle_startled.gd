extends State
class_name TurtleStartled


@export var character : CharacterBody2D
@onready var sprite = $"../../sprite"
@onready var animation_player = $"../../AnimationPlayer"


func Enter():
	character.spikes_out = true
	sprite.animation = "hit"
	animation_player.play("startled_anim")
	await get_tree().create_timer(0.3).timeout
	sprite.animation = "idle"
	await get_tree().create_timer(1.7).timeout
	sprite.animation = "spikes_out"
	await get_tree().create_timer(0.1).timeout
	animation_player.play("spikes_out")
	await get_tree().create_timer(0.2).timeout
	sprite.animation = "idle_spikes"
	await get_tree().create_timer(0.5).timeout
	character.startled = false
	state_transition.emit(self, "Idle")

func Exit():
	pass
	
func Update(_delta:float):
	pass
