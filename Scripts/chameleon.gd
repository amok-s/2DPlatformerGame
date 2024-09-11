extends CharacterBody2D


@onready var sprite = $Sprite

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed = 80

var go_right = false
var go_left = false
var taking_damage = false
var scale_switch = false
var player_detected = false

func _physics_process(delta):
	move_and_slide()
	if not is_on_floor():
		velocity.y += gravity * delta
	if (go_right == true):
		velocity.x = speed * delta * 70
	if (go_left == true):
		velocity.x = -speed * delta * 70
		
func _on_damage_collision_body_entered(body):
	if (body.name == "CharacterBody2D"):
		player_entered(body)
		
func  player_entered(body):
	var y_delta = get_node("DamageCollision").global_position.y - body.global_position.y
	var x_delta = body.global_position.x - get_node("DamageCollision").global_position.x
	
	if y_delta > 35:
		taking_damage = true
		body.velocity.y = -450
		$Death.play(0)
		%GameManager.spawn_blink()
		await get_tree().create_timer(2).timeout
		queue_free()
	else:
		body.taking_damage = true
		%GameManager.decrease_health()
		body.velocity.y = -300
		body.velocity.x = x_delta * 6.5
		await get_tree().create_timer(0.3).timeout
		body.taking_damage = false

func _on_patrol_area_body_entered(body):
	if (body.name == "CharacterBody2D"):
		player_detected = true
		await get_tree().create_timer(0.2).timeout
		$AnimationPlayer.play("lil_jump")
		
	
func _on_patrol_area_body_exited(body):
	if (body.name == "CharacterBody2D"):
		await get_tree().create_timer(0.4).timeout
		player_detected = false

func _on_tongue_attack_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var x_delta = body.global_position.x - get_node("DamageCollision").global_position.x
		body.taking_damage = true
		%GameManager.decrease_health()
		body.velocity.y = -400
		body.velocity.x = x_delta * 4.5
		await get_tree().create_timer(0.3).timeout
		body.taking_damage = false
