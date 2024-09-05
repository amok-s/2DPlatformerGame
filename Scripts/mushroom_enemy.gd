extends RigidBody2D
@onready var game_manager = %GameManager
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var bump_sound = $Bump
@onready var ledge_detector = $LedgeDetector/CollisionShape2D
@export var isStacionary: bool = false
@onready var collision_shape_2d2 = $Area2D/CollisionShape2D

var being_hit = false
var go_right = false
var can_go_right = true
var go_left = false
var can_go_left = true
var speed = 110

func _ready():
	await get_tree().create_timer(2).timeout
	if not isStacionary:
		wander_state()

func _process(delta):
	
	if being_hit == true:
		animated_sprite_2d.play("hit")
	else:
		if go_right == true and can_go_right == true:
			animated_sprite_2d.play("run")
			animated_sprite_2d.flip_h = true
			position += transform.x * speed * delta
		
		if go_left == true and can_go_left == true:
			animated_sprite_2d.play("run")
			position -= transform.x * speed * delta

#region: Mini State Machine
# Mini State Machine
func random_time():
	var random = randf_range(1.5, 2.4)
	return random
func wander_state():
	var random_direction = randi_range(1, 2)
	if random_direction == 1: #mushroom goes right
		go_right = true
		await get_tree().create_timer(random_time()).timeout
		go_right = false
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("idle")
		idle_state()
		
	else:
		go_left = true
		await get_tree().create_timer(random_time()).timeout
		go_left = false
		animated_sprite_2d.play("idle")
		idle_state()
func idle_state():
#endregion
	animated_sprite_2d.play("idle")
	await get_tree().create_timer(random_time()).timeout
	wander_state()

#region: Collision detection (player, walls and edges)
#Player and wall detection
func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		#print (y_delta)
		if (y_delta > 56): #Destroying the enemy
			collision_shape_2d.queue_free()
			collision_shape_2d2.queue_free()
			being_hit = true
			print ("Destroy enemy")
			body.jump()
			bump_sound.play(0)
			animated_sprite_2d.play("hit")
			var random_x = randf_range(-150, 150)
			set_axis_velocity(Vector2(random_x, -190))
			await get_tree().create_timer(2).timeout
			queue_free()
		else:                #Hurting the player
			game_manager.decrease_health()
			#print (x_delta)
			if (x_delta < 40): #if player touch enemy from the left
				print ("w lewo")
				body.jump_side(-500) 
			else: #approaching ftom the right
				print ("w prawo") 
				body.jump_side(500)
	
	if (body.name == "TileMap"):
		var x_delta = body.position.x - position.x
		print(x_delta)
		if (x_delta > -270): 
			can_go_left = false
		else: #approaching ftom the right
			can_go_right = false
func _on_area_2d_body_exited(body):
	if (body.name == "TileMap"):
		can_go_left = true
		can_go_right = true

#Edge detection
func _on_right_ledge_detector_body_exited(body):
	if body.name == "TileMap":
		go_right = false
		can_go_right = false
		animated_sprite_2d.play("idle")
func _on_right_ledge_detector_body_entered(body):
	if body.name == "TileMap":
		can_go_right = true
func _on_left_ledge_detector_body_exited(body):
	if body.name == "TileMap":
		go_left = false
		can_go_left = false
		animated_sprite_2d.play("idle")
func _on_left_ledge_detector_body_entered(body):
	if body.name == "TileMap":
		can_go_left = true

#endregion
