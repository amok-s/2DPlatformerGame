extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var bump_sound = $Bump
@onready var collision_shape_2d2 = $Area2D/CollisionShape2D

@export var isStacionary: bool = false

var being_hit = false

var can_go_right = true
var go_right = false
var can_go_left = true
var go_left = false

var speed = 110
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _process(delta):
	move_and_slide()
	
	velocity.y += gravity * delta
	
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
			collision_shape_2d.queue_free()
			collision_shape_2d2.queue_free()
			being_hit = true
			body.velocity.y = -550
			bump_sound.play(0)
			animated_sprite_2d.play("hit")
			await get_tree().create_timer(2).timeout
			queue_free()
			
		# when mushroom is hitting the player
		else:
			body.game_manager.decrease_health()
			#player is jumping left
			if (x_delta < 40):
				body.jump_side(-500) 
			#player is jumpring right
			else:
				body.jump_side(500)
	
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

