extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -840.0
@onready var sprite_2d = $Sprite2D
@onready var jump_sound = $JumpSound
@onready var pick_up = $PickUp



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	#Animations
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if (velocity.y < 0):
			sprite_2d.animation = "jumping"
		else:
			sprite_2d.animation = "fall"

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play(0)
 
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 12)

	move_and_slide()

	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft
	
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

