extends State
class_name BeeTakingDamage

@export var character : CharacterBody2D
@onready var sprite = $"../../sprite"
@onready var collision = $"../../Collision"
@onready var damage_collision = $"../../DamageCollision"
@onready var animation_player = $"../../AnimationPlayer"



func Enter():
	animation_player.pause()
	sprite.animation = "hit"
	collision.queue_free()
	damage_collision.queue_free()
	var random_x = randf_range(-120, 120)
	character.velocity.x = random_x
	character.velocity.y = -190
func Exit():
	pass
	
func Update(_delta:float):
	character.move_and_slide()
	character.velocity.y += character.gravity * _delta
