extends State
class_name PlayerTakingDamage

@export var being_hit_sound : AudioStreamPlayer
@export var player : CharacterBody2D
@export var sprite : AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func Enter():
	print(self.name)
	if player.jump_count == 2:
		player.jump_count = 1
	get_node("../../%GameManager").decrease_health()
	if get_node("../../%GameManager").lives <= 0 and get_node("../../%GameManager").cant_die == false:
		get_node("..").force_change_state("Death")
	else:
		get_node("../../%GameManager").spawn_sfx("player_hit", player.position)
		being_hit_sound.play(0)
		sprite.play("hit")
		player.sides_input_blockage = true
		player.jump_input_blockage = true
		DamageTimer()
	
func Update(_delta:float):
	if player.taking_damage == false:
		state_transition.emit(self, "Movement")
	
func Exit():
	player.sides_input_blockage = false
	player.jump_input_blockage = false

func DamageTimer():
		var timer = Timer.new()
		get_parent().get_parent().add_child(timer)
		timer.wait_time = 0.3
		timer.one_shot = true
		timer.connect("timeout", StopDamage)
		timer.start()

func StopDamage():
	player.taking_damage = false
