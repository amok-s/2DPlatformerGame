extends RigidBody2D
@onready var game_manager = %GameManager
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var bump_sound = $Bump



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		



func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		#print (y_delta)
		if (y_delta > -400):
			print ("Destroy enemy")
			body.jump()
			bump_sound.play(0)
			animated_sprite_2d.play("hit")
			var random_x = randf_range(-150, 150)
			set_axis_velocity(Vector2(random_x, -190))
			collision_shape_2d.queue_free()
			await get_tree().create_timer(2).timeout
			queue_free()
		else:
			print ("Decrease player health")
			game_manager.decrease_health()
			#print (x_delta)
			if (x_delta < 660): #if player touch enemy from the left
				print ("w lewo")
				body.jump_side(-500) 
			else: #approaching ftom the right
				print ("w prawo") 
				body.jump_side(500)
