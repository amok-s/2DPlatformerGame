extends CharacterBody2D

@onready var game_manager = %GameManager

@export var sprite : AnimatedSprite2D
@export var jump_sound : AudioStreamPlayer

@export var particle : PackedScene
@export var appearing : PackedScene


var SPEED = 340.0
const JUMP_VELOCITY = -840.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0

var sides_input_blockage = false
var jump_input_blockage = false
var taking_damage = false

func jump():
	velocity.y = -350

func jump_side(x):
	taking_damage = true
	velocity.y = -550
	velocity.x = x
	await get_tree().create_timer(0.3).timeout
	taking_damage = false

func hit_by_spikes(x, y):
	taking_damage = true
	velocity.y = y 
	velocity.x = x 
	await get_tree().create_timer(0.3).timeout
	taking_damage = false

func hit_by_plant():
	game_manager.decrease_health()
	velocity.y = -550
	taking_damage = true
	await get_tree().create_timer(0.3).timeout
	taking_damage = false

func spawn_particle():
	var particle_node = particle.instantiate()
	particle_node.position = position
	get_parent().add_child(particle_node)
	await get_tree().create_timer(0.3).timeout
	particle_node.queue_free()

func _physics_process(delta):
	
	#handling gravity
	move_and_slide()
	
	if is_on_floor():
		jump_count = 0
	
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (jump_count < 2) and (jump_input_blockage == false):
		velocity.y = JUMP_VELOCITY
		jump_sound.play(0)
		jump_count += 1
		if (jump_count == 2):
			spawn_particle()
		
		
	var direction = Input.get_axis("left", "right")
	if direction and (sides_input_blockage == false):
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 15.5)
	
	var isLeft = velocity.x < 0
	sprite.flip_h = isLeft
	pass
	
