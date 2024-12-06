extends State
class_name BatDamage

@onready var sprite = $"../../sprite"
@onready var bat = $"../.."

var player_spotted : bool = true

func Enter():
	$"../../Collision".queue_free()
	$"../../DamageCollision".queue_free()
	sprite.play("hit")
	var random_x = randf_range(70, 140)
	var random_direction = randf_range(1, 2)
	if random_direction == 1:
		bat.velocity.x = random_x
	else:
		bat.velocity.x = -random_x
	bat.velocity.y = -190

func Exit():
	pass
	
func Update(_delta:float):
	bat.velocity.y += bat.gravity * 0.65 * _delta
	
