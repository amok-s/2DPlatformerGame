extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed = 15

var go_left = false
var go_right = false
var taking_damage = false
var facing_right = false
var startled = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
	
	if (go_right == true):
		velocity.x = speed * delta * 70
	if (go_left == true):
		velocity.x = -speed * delta * 70



	
func _on_body_collision_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var y_delta = $BodyCollision.global_position.y - body.global_position.y
		print(y_delta)
		if y_delta > 35:
			taking_damage = true
			body.velocity.y = -550
			$Death.play(0)
			startled = true
			#await get_tree().create_timer(2).timeout
			#queue_free()
