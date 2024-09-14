extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var bump_sound = $Bump
@onready var collision_shape_2d2 = $Area2D/CollisionShape2D


@export var sfx : PackedScene
@export var isStacionary: bool = false


var can_go_right = true
var go_right = false
var can_go_left = true
var go_left = false

var speed = 110
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _process(delta):
	move_and_slide()
	
	if not is_on_floor():
		velocity.y += gravity * delta * 0.7
	
	if (go_right == true):
		velocity.x = speed * delta * 70
	if (go_left == true):
		velocity.x = -speed * delta * 70

	var isRight = velocity.x > 0
	animated_sprite_2d.flip_h = isRight


func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		# when mushroom is destroyed
		if (y_delta > 56):
			%GameManager.spawn_blink()
			collision_shape_2d.queue_free()
			collision_shape_2d2.queue_free()
			body.velocity.y = -550
			%GameManager.spawn_sfx("kill", position + Vector2(0, -20))
			bump_sound.play(0)
			$StateMachine.force_change_state("TakingDamage")
		
		# when mushroom is hitting the player
		else:
			#player is jumping left
			if (x_delta < 40):
				body.take_damage(-450, -550)
			#player is jumpring right
			else:
				body.take_damage(450, -550)
	
		#mushroom collading with walls
	if (body.name == "TileMap"):
		var x_delta = body.position.x - position.x
		#collading from the left
		if (x_delta > -270): 
			can_go_left = false
		#collading from the right
		else: 
			can_go_right = false

func _on_area_2d_body_exited(body):
	if (body.name == "TileMap"):
		can_go_left = true
		can_go_right = true
