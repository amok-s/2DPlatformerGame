extends State
class_name BeeAttack

@onready var bee = $"../.."
@onready var attack_sound = $"../../Attack"
@onready var sprite = $"../../sprite"
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
		var tween = get_tree().create_tween()
		tween.tween_property(bee, "global_position", bee.chase_position, 1.7)
		await get_tree().create_timer(1.9).timeout
		state_transition.emit(self, "Idle")
		
	if bee.player_spotted == true:
		follow_player()
	if can_attack == true:
		attack()
	
func attack_timer():
	if get_tree():
		await get_tree().create_timer(randf_range(0.2, 1.2)).timeout
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

func follow_player():
	if bee.player:
		var tween = get_tree().create_tween()
		tween.tween_property(bee, "global_position", Vector2(bee.player.global_position.x, bee.player.global_position.y - 240), 2)
