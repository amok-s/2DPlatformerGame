extends State
class_name BeeAttack

@onready var bee = $"../.."
@onready var attack_sound = $"../../Attack"
@onready var sprite = $"../../sprite"
@export var stinger : PackedScene

var can_attack = false
var change_to_idle = false
var chase = true

func Enter():
	change_to_idle = false
	bee.chase_position = bee.global_position
	chase = true
	attack()
	state_timer()
	
func Exit():
	can_attack = false
	await get_tree().create_timer(randf_range(1.4, 2.8)).timeout
	$"../Idle".calm = false
	
func Update(_delta:float):
	if bee.taking_damage == true:
		state_transition.emit(self, "TakingDamage")
	
	if change_to_idle == true:
		chase = false
		bee.velocity = Vector2(0, 0)
		change_to_idle = false
		var tween = get_tree().create_tween()
		tween.tween_property(bee, "global_position", bee.chase_position, 1.7)
		await get_tree().create_timer(1.8).timeout
		state_transition.emit(self, "Idle")
	
	if chase:
		calculate_velocity()
		
	if can_attack == true:
		attack()
		
	bee.move_and_slide()
	
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
	get_parent().add_child(b)


func state_timer():
	await get_tree().create_timer(randf_range(1.8, 3.2)).timeout
	change_to_idle = true

func calculate_velocity():
	var distance_to_player = 20
	var player_position = bee.player.global_position + Vector2(0, -180)
	
	if bee.global_position.distance_to(player_position) > distance_to_player:
		var direction = (player_position - bee.global_position).normalized()
		bee.velocity = direction * bee.speed * 1.3
		bee.velocity.x *= 1.3
	else: 
		bee.velocity.x += 0.5
		bee.velocity.y -= 12
