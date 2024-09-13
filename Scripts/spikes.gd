extends StaticBody2D

@onready var game_manager = %GameManager


func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var y_delta = (position.y - body.position.y)
		var x_delta = (body.position.x - position.x)
		body.take_damage(350 if x_delta > 0 else -350, -550)
