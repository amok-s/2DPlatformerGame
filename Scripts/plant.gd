extends RigidBody2D

@export var bullet : PackedScene
@export var sprite : AnimatedSprite2D
@export var spawn_projectile_sound : AudioStreamPlayer2D


@onready var player = $"../Scene Objects/CharacterBody2D"

var shooting = false


func timer():
	var random = randf_range(0, 4)
	await get_tree().create_timer(random).timeout
	shooting = true

func _ready():
	timer()
	pass 


func _process(delta):
	
	if (shooting == true):
		shooting = false
		sprite.animation = "attack"
		await get_tree().create_timer(0.5).timeout
		shoot()
		sprite.animation = "idle"
		timer()

	var playerOnRight = (player.position.x - position.x) > 0
	sprite.flip_h = playerOnRight

func shoot():
	
	if ((player.position.x - position.x) > 0):
		var b = bullet.instantiate()
		b.position = position + Vector2(55, -8)
		b.rotate(PI)
		get_parent().add_child(b)
	else:
		var b = bullet.instantiate()
		b.position = position + Vector2(-55, -8)
		get_parent().add_child(b)

	spawn_projectile_sound.play(0)
	print ("adding plant projectile")
