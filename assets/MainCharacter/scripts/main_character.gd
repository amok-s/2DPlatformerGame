extends CharacterBody2D

@onready var game_manager = %GameManager
@onready var footstep_audio : AudioStreamPlayer2D = get_node(NodePath("Footstep"))



@export var sprite : AnimatedSprite2D
@export var jump_sound : AudioStreamPlayer

@export var jump_particle : PackedScene
@export var dust_particle: PackedScene
@export var appearing : PackedScene




var SPEED = 360.0
const JUMP_VELOCITY = -840.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0
var speed_modifier = 1
var jump_modifier = 1

var sides_input_blockage = false
var jump_input_blockage = false
var taking_damage = false
var is_grounded = true

func take_damage(x, y, willTakeDamage = true):
	if willTakeDamage == true:
		taking_damage = true
	velocity.x = x
	velocity.y = y

func spawn_dust():
	var particle_node = dust_particle.instantiate()
	particle_node.position = position + Vector2(-1, 18)
	particle_node.scale = Vector2(2, 2)
	get_parent().add_child(particle_node)
	
func outlineBlink():
	$Sprite2D.outlineBlink()

func _physics_process(delta):
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
		velocity.y = JUMP_VELOCITY * jump_modifier
		jump_sound.play(0)
		jump_count += 1
		if (jump_count == 2):
			%GameManager.spawn_sfx("double_jump", position, 0, Vector2(3, 3)) 
		
		
	var direction = Input.get_axis("left", "right")
	if direction and sides_input_blockage == false:
		velocity.x = direction * SPEED * speed_modifier
		if is_on_floor():
			$"AnimationPlayers/FootstepAnimation".play("footsteps")
	else:
		velocity.x = move_toward(velocity.x, 0, 18 if not is_on_floor() else 50,)
	
	
	
func playFootstepAudio():
	footstep_audio.pitch_scale = randf_range(1.3, 2)
	footstep_audio.play(0)
	
