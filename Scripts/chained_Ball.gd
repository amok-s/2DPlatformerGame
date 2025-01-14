extends Sprite2D

func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var x_delta = body.global_position.x - get_node("StaticBody2D").global_position.x
	
		body.take_damage(500 if x_delta > 0 else -500, -350)
