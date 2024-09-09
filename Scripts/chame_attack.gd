extends State
class_name ChameleonAttack

@export var character: CharacterBody2D
@export var sprite = AnimatedSprite2D

var can_attack = false

func Enter():
	can_attack = false
	sprite.animation = "idle"
	await get_tree().create_timer(randf_range(1.7, 1.2)).timeout
	can_attack = true
func Exit():
	character.player_detected = false
	
func Update(_delta:float):
	if can_attack == true:
		can_attack = false
		attack()
		attack_timer()
	
	if (character.taking_damage == true):
		state_transition.emit(self, "TakingDamage")
	
	if (character.player_detected == false):
		state_transition.emit(self, "Idle")

func attack_timer():
	await get_tree().create_timer(randf_range(2.7, 4.2)).timeout
	can_attack = true
	
func attack():
		sprite.animation = "attack"
		await get_tree().create_timer(0.45).timeout
		get_node("../../TongueAttack/AnimationPlayer").play("tongue_attack")
		await get_tree().create_timer(1.1).timeout
		sprite.animation = "idle"
