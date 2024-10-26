extends State
class_name PlayerDeath

@export var player : CharacterBody2D
@export var sprite : AnimatedSprite2D
@onready var dead_sound = $"../../DeadSound"
@onready var collision_shape = $"../../CollisionShape2D"

var death_pos

func Enter():
	print(self.name)
	death_pos = player.get_global_position()
	collision_shape.queue_free()
	player.velocity.x = 0
	player.velocity.y = 0
	player.gravity = 0
	player.jump_input_blockage = true
	player.sides_input_blockage = true
	player.taking_damage = true
	sprite.play("dead")
	dead_sound.play(0)
	await get_tree().create_timer(0.3).timeout
	sprite.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func Update(_delta:float):
	player.global_position = death_pos

func Exit():
	pass
