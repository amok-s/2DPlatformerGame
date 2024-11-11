extends State
class_name ChameleonAttack

@export var character: CharacterBody2D
@onready var sprite = $"../../Sprite"



var can_attack = false

func Enter():
	can_attack = false
	sprite.animation = "idle"
	await get_tree().create_timer(randf_range(0.3, 0.8)).timeout
	can_attack = true
func Exit():
	can_attack = false
	pass
	
func Update(_delta:float):
	if can_attack == true:
		can_attack = false
		attack()

	if (character.taking_damage == true):
		state_transition.emit(self, "TakingDamage")

func attack_timer():
	await get_tree().create_timer(randf_range(3.0, 4.2)).timeout
	if character.player_detected == false:
		state_transition.emit(self, "Idle")
	else:
		can_attack = true
	
func attack():
		sprite.play("attack")
		await get_tree().create_timer(0.45).timeout
		get_node("../../TongueAttack/AnimationPlayer").play("tongue_attack")
		character.mlem()
		await get_tree().create_timer(1.1).timeout
		sprite.animation = "idle"
		attack_timer()
