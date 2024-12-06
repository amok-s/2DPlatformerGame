extends State
class_name BeeTakingDamage

@onready var bee = $"../.."
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
	bee.velocity.x = random_x
	bee.velocity.y = -190

func Exit():
	pass
	
func Update(_delta:float):
	bee.move_and_slide()
	bee.velocity.y += bee.gravity * 0.65 * _delta
