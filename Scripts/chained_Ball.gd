extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		#body.hit_by_plant()
		hit_by_ball(body)

func hit_by_ball(body):
	var y_delta = get_node("StaticBody2D").global_position.y - body.global_position.y
	var x_delta = body.global_position.x - get_node("StaticBody2D").global_position.x
	body.taking_damage = true
	if y_delta > 15:
		body.velocity.y = -350
	else:
		body.velocity.y = -180
	body.velocity.x = x_delta * 11.5
	%GameManager.decrease_health()
	await get_tree().create_timer(0.3).timeout
	body.taking_damage = false
	pass
