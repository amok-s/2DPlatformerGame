extends State
class_name BeeAttack

@export var character : CharacterBody2D
@onready var attack_sound = $"../../Attack"
@onready var sprite = $"../../sprite"
@onready var animation_player = $"../../AnimationPlayer"

var can_attack = false

func Enter():
	print("attack")
	animation_player.pause()
	attack()
	
func Exit():
	can_attack = false
	
func Update(_delta:float):
	if character.taking_damage == true:
		state_transition.emit(self, "TakingDamage")
	
	if character.player_spotted == false:
		state_transition.emit(self, "Idle")
		
	if can_attack == true:
		attack()
	
func attack_timer():
	await get_tree().create_timer(randf_range(2.8, 4.0)).timeout
	can_attack = true

func attack():
	can_attack = false
	sprite.play("attack")
	await get_tree().create_timer(0.4).timeout
	attack_sound.play(0)
	await get_tree().create_timer(0.2).timeout
	sprite.play("idle")
	attack_timer()
