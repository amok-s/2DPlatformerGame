extends AnimatedSprite2D

func _ready():
	idle()

func _on_damage_area_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var x_delta = body.global_position.x - global_position.x
	
		body.take_damage(500 if x_delta > 0 else -500, -350)

func blinkTimer():
	play("blink")
	animation_finished.connect(idle)

func idle():
	animation = "idle"
	await get_tree().create_timer(randf_range(1.3, 2)).timeout
	blinkTimer()
