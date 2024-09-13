extends Sprite2D

var speed = 300

func _process(delta):
	position += transform.y * speed * delta


func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D":
		$Area2D.queue_free()
		hide()
		body.take_damage(0, -450)
		queue_free()
	elif body.name == "TileMap":
		queue_free()
