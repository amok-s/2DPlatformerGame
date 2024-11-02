extends State
class_name BeeAttack

@onready var bee = $"../.."
@onready var attack_sound = $"../../Attack"
@onready var sprite = $"../../sprite"
@onready var animation_player = $"../../AnimationPlayer"
@export var stinger : PackedScene

var can_attack = false

func Enter():
	attack()
	
func Exit():
	can_attack = false
	
func Update(_delta:float):
	if bee.taking_damage == true:
		state_transition.emit(self, "TakingDamage")
	
	if bee.player_spotted == false:
		state_transition.emit(self, "Idle")
		
	if can_attack == true:
		attack()
	
func attack_timer():
	if get_tree():
		await get_tree().create_timer(randf_range(2, 2.7)).timeout
		can_attack = true

func attack():
	can_attack = false
	sprite.play("attack")
	await get_tree().create_timer(0.4).timeout
	attack_sound.play(0)
	await get_tree().create_timer(0.1).timeout
	spawn_stinger()
	await get_tree().create_timer(0.2).timeout
	sprite.play("idle")
	attack_timer()

func spawn_stinger():
	var b = stinger.instantiate()
	b.position = bee.global_position + Vector2(0, 20)
	print(b.position)
	get_parent().add_child(b)
