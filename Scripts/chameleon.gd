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
	
	if y_delta > 50:
		taking_damage = true
		body.velocity.y = -450
		$Death.play(0)
		%GameManager.spawn_blink()
		%GameManager.spawn_sfx("dust_2", position + Vector2(0, -15))
		Stats.mobs_killed += 1
		Stats.chameleon_killed += 1
		await get_tree().create_timer(2).timeout
		queue_free()
	else:	
		body.take_damage(-400 if x_delta < 0 else 400, -300)

func _on_patrol_area_body_entered(body):
	if (body.name == "CharacterBody2D"):
		player_detected = true
		await get_tree().create_timer(0.2).timeout
		$AnimationPlayer.play("lil_jump")
		if body.position.x - position.x > 0 && scale_switch == false:
			scale.x = -2
			scale_switch = true
		elif body.position.x - position.x < 0 && scale_switch == true:
			scale.x = -2
			scale_switch = false
		
	
func _on_patrol_area_body_exited(body):
	if (body.name == "CharacterBody2D"):
		await get_tree().create_timer(0.6).timeout
		player_detected = false

func _on_tongue_attack_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var x_delta = body.global_position.x - get_node("DamageCollision").global_position.x
		body.take_damage(x_delta *4.5, -400)

func mlem():
	if get_tree():
		await get_tree().create_timer(0.2).timeout
		%GameManager.spawn_text_sfx("mlem", position)
