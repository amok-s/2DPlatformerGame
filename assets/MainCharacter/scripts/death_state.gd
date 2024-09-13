extends State
class_name PlayerDeath

@export var player : CharacterBody2D
@export var sprite : AnimatedSprite2D
@onready var dead_sound = $"../../DeadSound"


func Enter():
	print(self.name)
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
	pass

func Exit():
	pass
