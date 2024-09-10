extends Sprite2D

var speed = 200

func _process(delta):
	position += transform.y * speed * delta


func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D":
		$Area2D.queue_free()
		hide()
		body.game_manager.decrease_health()
		body.velocity.y = -450
		body.taking_damage = true
		await get_tree().create_timer(0.3).timeout
		body.taking_damage = false
		await get_tree().create_timer(0.3).timeout
		queue_free()
	elif body.name == "TileMap":
		queue_free()
