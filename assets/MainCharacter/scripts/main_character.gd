extends CharacterBody2D

@onready var game_manager = %GameManager

@export var sprite : AnimatedSprite2D
@export var jump_sound : AudioStreamPlayer

@export var jump_particle : PackedScene
@export var dust_particle: PackedScene
@export var appearing : PackedScene


var SPEED = 340.0
const JUMP_VELOCITY = -840.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0

var sides_input_blockage = false
var jump_input_blockage = false
var taking_damage = false
var is_grounded = true

func take_damage(x, y, willTakeDamage = true):
	if willTakeDamage == true:
		taking_damage = true
	velocity.x = x
	velocity.y = y

func spawn_jump_particle():
	var particle_node = jump_particle.instantiate()
	particle_node.position = position
	get_parent().add_child(particle_node)
	await get_tree().create_timer(0.3).timeout
	particle_node.queue_free()

func spawn_dust():
	var particle_node = dust_particle.instantiate()
	particle_node.position = position + Vector2(-1, 18)
	particle_node.scale = Vector2(2, 2)
	get_parent().add_child(particle_node)

func _physics_process(delta):
	#handling gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()
	
	if is_grounded == false and is_on_floor() == true:
		spawn_dust()
	
	
	is_grounded = is_on_floor()
	
	if is_on_floor():
		jump_count = 0
	

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (jump_count < 2) and (jump_input_blockage == false):
		velocity.y = JUMP_VELOCITY
		jump_sound.play(0)
		jump_count += 1
		if (jump_count == 2):
			spawn_jump_particle()
		
		
	var direction = Input.get_axis("left", "right")
	if direction and sides_input_blockage == false:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 15.5)
	
	var isLeft = velocity.x < 0
	sprite.flip_h = isLeft
	

	
