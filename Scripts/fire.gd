extends StaticBody2D

func _on_damage_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var x_delta = (body.position.x - position.x)
		body.take_damage(350 if x_delta > 0 else -350, -550)
