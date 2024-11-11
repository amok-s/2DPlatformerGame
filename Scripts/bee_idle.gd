extends State
class_name BeeIdle


@onready var bee = $"../.."
@onready var sprite = $"../../sprite"

var calm = false

func Enter():
	sprite.animation = "idle"

func Exit():
	pass
	
func Update(_delta:float):
	if bee.taking_damage == true:
		state_transition.emit(self, "TakingDamage")

	if bee.path:
		bee.path.progress += _delta * bee.speed

func _on_player_detector_body_entered(body):
	if body.name == "CharacterBody2D" and !calm:
		calm = true
		bee.player = body
		$"../../AnimationPlayer".play("rage")
		$"../../Rage".play(0)
		bee.get_node("../%GameManager").spawn_text_sfx("enraged", bee.global_position)
		await get_tree().create_timer(0.4).timeout
		$"../../AnimationPlayer".play_backwards("rage")
		state_transition.emit(self, "Attack")

func calm_timer():
	await get_tree().create_timer(randf_range(2.6, 3.5)).timeout
	calm = false
