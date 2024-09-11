extends Sprite2D

var hitted = false

func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		if not hitted:
			hit_by_ball(body)

func hit_by_ball(body):
	hitted = true
	var y_delta = get_node("StaticBody2D").global_position.y - body.global_position.y
	var x_delta = body.global_position.x - get_node("StaticBody2D").global_position.x
	body.taking_damage = true
	%GameManager.decrease_health()
	body.velocity.y = -350
	if x_delta > 0:
		body.velocity.x = 500
	else:
		body.velocity.x = -500
	await get_tree().create_timer(0.3).timeout
	body.taking_damage = false
	hitted = false
