extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed = 15

var go_left = false
var go_right = false
var taking_damage = false
var facing_right = false
var startled = false
var spikes_out = false
var spike_counter = 0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
	
	if (go_right == true):
		velocity.x = speed * delta * 70
	if (go_left == true):
		velocity.x = -speed * delta * 70



	
func _on_body_collision_body_entered(body):
	if (body.name == "CharacterBody2D" and not spikes_out):
		var y_delta = $BodyCollision.global_position.y - body.global_position.y
		print(y_delta)
		if y_delta > 35:
			%GameManager.spawn_blink()
			taking_damage = true
			body.velocity.y = -550
			$Death.play(0)
			startled = true


func _on_spikes_collision_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var y_delta = $SpikesCollision.global_position.y - body.global_position.y
		var x_delta = body.global_position.x - $SpikesCollision.global_position.x
		if y_delta > 15:
			body.take_damage(x_delta * 10, - 550)
		else:
			body.take_damage(x_delta * 8, -450)

