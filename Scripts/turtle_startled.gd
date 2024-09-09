extends State
class_name TurtleStartled


@export var character : CharacterBody2D
@onready var sprite = $"../../sprite"
@onready var animation_player = $"../../AnimationPlayer"


func Enter():
	sprite.animation = "idle"
	animation_player.play("startled_anim")
	await get_tree().create_timer(2).timeout
	sprite.animation = "spikes_out"
	animation_player.play("spikes_out")
	await get_tree().create_timer(0.3).timeout
	sprite.animation = "idle_spikes"
	pass

func Exit():
	pass
	
func Update(_delta:float):
	pass
