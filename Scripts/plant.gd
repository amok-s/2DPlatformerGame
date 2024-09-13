extends RigidBody2D

@export var bullet : PackedScene
@export var sprite : AnimatedSprite2D

@export var kill_sound : AudioStreamPlayer2D
@export var spawn_projectile_sound : AudioStreamPlayer2D
@export var player: CharacterBody2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var area_2d = $Area2D

var shooting = false

func timer():
	var random = randf_range(0, 4)
	await get_tree().create_timer(random).timeout
	shooting = true

func _ready():
	timer()
	pass 

func _process(_delta):
	
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
	
	if ((player.position.x - position. x) > 0):
		var b = bullet.instantiate()
		b.position = position + Vector2(55, -8)
		b.rotate(PI)
		get_parent().get_parent().add_child(b)
	else:
		var b = bullet.instantiate()
		b.position = position + Vector2(-55, -8)
		get_parent().get_parent().add_child(b)

	spawn_projectile_sound.play(0)

func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		print (y_delta)
		if (y_delta > 30):
			%GameManager.spawn_blink()
			collision_shape_2d.queue_free()
			area_2d.queue_free()
			shooting = false
			body.velocity.y = -450
			kill_sound.play(0)
			sprite.play("hit")
			var random_x = randf_range(-150, 150)
			set_axis_velocity(Vector2(random_x, -190))
			await get_tree().create_timer(4).timeout
			queue_free()
		else:
			print ("Decrease player health")
			%GameManager.decrease_health()
			print (x_delta)
			if (x_delta < 5): #if player touch enemy from the left
				print ("w lewo")
				body.jump_side(-380) 
			else: #approaching from the right
				print ("w prawo") 
				body.jump_side(380)
