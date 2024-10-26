extends Area2D


func _on_body_entered(body):
	if (body.name == "CharacterBody2D") and %GameManager.cant_die == false:
		%GameManager.player_dead()
