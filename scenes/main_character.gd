extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -840.0
@onready var sprite_2d = $Sprite2D
@onready var jump_sound = $JumpSound
@onready var pick_up = $PickUp 
@onready var game_manager = %GameManager
@onready var being_hit = $BeingHit
@onready var dead_sound = $DeadSound




# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0
var taking_damage = false

func jump():
	velocity.y = -350
	
func jump_side(x):
	velocity.y = -550
	velocity.x = x
	if (game_manager.lives != 0):
		taking_damage = true
		being_hit.play(0)
		await get_tree().create_timer(0.3).timeout
		taking_damage = false
	
	
func dead():
	if (game_manager.lives == 0):
		dead_sound.play(0)
		print ("dead")

func _physics_process(delta):
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
	if Input.is_action_just_pressed("jump") and jump_count < 2:
		velocity.y = JUMP_VELOCITY
		jump_sound.play(0)
		jump_count += 1
		
	
 
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction and (taking_damage == false):
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 12)

	move_and_slide()

	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft

	

