extends State
class_name BatSleeping

@onready var sprite = $"../../sprite"
@onready var bat = $"../.."


var player_spotted : bool = true
var sleep_sfx = false

func Enter():
	$"../../DetectionArea".connect("body_entered", BodySpotted)

func Exit():
	player_spotted = true
	
func Update(_delta:float):
	if !sleep_sfx:
		sleep_sfx = true
		spawn_sleeping_sfx()
	
func BodySpotted(body):
	if body.name == "CharacterBody2D":
		if player_spotted:
			player_spotted = false
			state_transition.emit(self, "Flying")

func spawn_sleeping_sfx():
	bat.get_node("../%GameManager").spawn_text_sfx("sleeping", bat.global_position)
	if get_tree():
		await get_tree().create_timer(randf_range(3.4, 5.5)).timeout
		sleep_sfx = false
