extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -840.0

@onready var sprite_2d = $Sprite2D
@onready var pick_up = $PickUp 
@onready var game_manager = %GameManager

#sound effects
@onready var being_hit = $BeingHit
@onready var dead_sound = $DeadSound
@onready var appear_sound = $AppearSound
@onready var jump_sound = $JumpSound

@export var particle : PackedScene
@export var appearing : PackedScene




# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0
var sides_input_blockage = false
var jump_input_blockage = false
var starting_anim = true
var taking_damage = false

func jump():
	velocity.y = -350
	
func jump_side(x):
	velocity.y = -550
	velocity.x = x
	if (game_manager.lives != 0):
		sides_input_blockage = true
		taking_damage = true
		being_hit.play(0)
		await get_tree().create_timer(0.2).timeout
		sides_input_blockage = false
		taking_damage = false
	
func hit_by_spikes(x, y):
	taking_damage = true
	sides_input_blockage = true
	being_hit.play(0)
	velocity.y = y
	velocity.x = x
	await get_tree().create_timer(0.3).timeout
	sides_input_blockage = false
	await get_tree().create_timer(0.2).timeout
	taking_damage = false
	
func hit_by_plant():
	#game_manager.decrease_health()
	sides_input_blockage = true
	taking_damage = true
	being_hit.play(0)
	velocity.y = -500
	await get_tree().create_timer(0.3).timeout
	sides_input_blockage = false
	await get_tree().create_timer(0.2).timeout
	taking_damage = false

func _physics_process(delta):
	
	# starting animation
	if (starting_anim == true):
		sprite_2d.hide()
		gravity = 0
		sides_input_blockage = true
		jump_input_blockage = true
		var appearing_node = appearing.instantiate(0)
		appearing_node.position = position
		get_parent().add_child(appearing_node)
		starting_anim = false
		await get_tree().create_timer(0.68).timeout
		appear_sound.play(0)
		appearing_node.queue_free()
		sprite_2d.show()
		gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
		sides_input_blockage = false
		jump_input_blockage = false
	
	#Gravity and animations
	if (taking_damage == true):
		sprite_2d.play("hit")
	
	
	if (game_manager.lives == 0):
		sprite_2d.play("dead")
		await get_tree().create_timer(0.6).timeout
	
	if is_on_floor():
		jump_count = 0
	
		if (velocity.x > 1 || velocity.x < -1):
			sprite_2d.animation = "running"
		else:
			sprite_2d.animation = "default"
	
	if not is_on_floor():
		velocity.y += gravity * delta
		# More animations(velocity.y < 0)
		if (velocity.y > 0) and (jump_count == 0):
			sprite_2d.animation = "fall"
		else:
			if (jump_count == 1):
				sprite_2d.animation = "jumping"
			if (jump_count == 2):
				sprite_2d.play("double_jumping")
			if (velocity.y > 0) and (jump_count == 1):
				sprite_2d.animation = "fall"
	
		
		

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (jump_count < 2) and (jump_input_blockage == false):
		velocity.y = JUMP_VELOCITY
		jump_sound.play(0)
		jump_count += 1
		if (jump_count == 2):
			spawn_particle()
		
	
 
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction and (sides_input_blockage == false):
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 12)

	move_and_slide()

	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft

	
func spawn_particle():
	var particle_node = particle.instantiate()
	particle_node.position = position
	get_parent().add_child(particle_node)
	await get_tree().create_timer(0.3).timeout
	particle_node.queue_free()
