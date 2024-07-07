extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var game_manager = %GameManager
@onready var pick_up = $PickUp
@onready var collision_shape_2d = $CollisionShape2D




func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		animated_sprite_2d.animation = "collected"
		game_manager.add_point()
		pick_up.play(0)
		collision_shape_2d.queue_free()


func _on_pick_up_finished():
	queue_free()
