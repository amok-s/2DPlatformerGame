extends CharacterBody2D

@export var bullet : PackedScene
@export var sprite : AnimatedSprite2D

@export var kill_sound : AudioStreamPlayer2D
@export var spawn_projectile_sound : AudioStreamPlayer2D
@export var player: CharacterBody2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var area_2d = $Area2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var canShoot = true

func timer():
	var random = randf_range(0, 4)
	if get_tree():
		await get_tree().create_timer(random).timeout
		shoot()


func _ready():
	timer()
	pass 

func _process(_delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y += gravity * _delta
		
	var playerOnRight = (player.position.x - position.x) > 0
	sprite.flip_h = playerOnRight

func shoot():
	if canShoot:
		sprite.animation = "attack"
		await get_tree().create_timer(0.5).timeout
		if ((player.position.x - position. x) > 0):
			var b = bullet.instantiate()
			b.position = position + Vector2(55, -8)
			b.rotate(PI)
			get_parent().add_child(b)
		else:
			var b = bullet.instantiate()
			b.position = position + Vector2(-55, -8)
			get_parent().add_child(b)

		spawn_projectile_sound.play(0)
		sprite.animation = "idle"
		timer()
func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		print (y_delta)
		if (y_delta > 30):
			canShoot = false
			%GameManager.spawn_blink()
			%GameManager.spawn_sfx("kill", position + Vector2(0, -25))
			collision_shape_2d.queue_free()
			area_2d.queue_free()
			body.velocity.y = -450
			kill_sound.play(0)
			sprite.play("hit")
			var random_x = randf_range(-150, 150)
			velocity.x = random_x
			velocity.y = -190
			await get_tree().create_timer(3).timeout
			queue_free()
		else:
			if (x_delta < 5): #if player touch enemy from the left
				body.take_damage(-380, -550)
			else: #approaching from the right
				body.take_damage(380, -550)
