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
var scale_switch = false
var shooting_time = false
var wait_time = false

func timer():
	wait_time = false
	var random = randf_range(0.2, 4)
	if get_tree():
		await get_tree().create_timer(random).timeout
		shooting_time = true


func _ready():
	timer()
	
func _process(_delta):
	checkPlayerPosition()
	if shooting_time:
		shoot()
	if wait_time:
		timer()
		
	move_and_slide()
	if not is_on_floor():
		velocity.y += gravity * _delta
		

func shoot():
	shooting_time = false
	sprite.animation = "attack"
	await get_tree().create_timer(0.5).timeout
	
	var b = bullet.instantiate()
	b.position = position + Vector2(55 if scale_switch == true else -55, -8)
	if scale_switch == true:
		b.rotate(PI) 
	get_parent().add_child(b)
	spawn_projectile_sound.play(0)
	sprite.animation = "idle"
	wait_time = true
	
func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		print (y_delta)
		if (y_delta > 30): #kill the plant
			shooting_time = false
			wait_time = false
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
		else: #hurting the player
			if (x_delta < 5): #if player touch enemy from the left
				body.take_damage(-380, -550)
			else: #approaching from the right
				body.take_damage(380, -550)

func checkPlayerPosition():
	if player.position.x - position.x > 0 and scale_switch == false:
		await get_tree().create_timer(0.4).timeout
		if player.position.x - position.x > 0 and scale_switch == false:
			scale.x = -scale.x
			scale_switch = true
	elif player.position.x - position.x < 0 and scale_switch == true:
		await get_tree().create_timer(0.4).timeout
		if player.position.x - position.x < 0 and scale_switch == true:
			scale.x = -scale.x
			scale_switch = false
	
