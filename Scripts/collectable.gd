extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var game_manager = %GameManager
@onready var pick_up = $PickUp
@onready var collision_shape_2d = $CollisionShape2D


@export_enum("ananas", "apple", "banana", "cherry", "kiwi", "melon", "orange", "strawberry") var fruit: String = "Rebecca"
@export var random_fruit: bool = true

var fruits: Array = ["ananas", "apple", "banana", "cherry", "kiwi", "melon", "orange", "strawberry"]

func _ready():
	if random_fruit == true:
		animated_sprite_2d.animation = fruits.pick_random()
	else:
		animated_sprite_2d.animation = fruit

func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		hide()
		
		game_manager.spawn_sfx("collect", position, 0, Vector2(3, 3))
		if game_manager.get_parent().fruits_left_to_show_sfx > game_manager.fruits_amount - game_manager.fruits_count:
			if game_manager.fruits_amount - game_manager.fruits_count - 1 != 0:
				game_manager.spawn_text_sfx("fruits left", position, game_manager.fruits_amount - game_manager.fruits_count - 1)
		game_manager.add_point()
		game_manager.add_fruit()
		
		if (game_manager.fruits_count != game_manager.fruits_amount):
			pick_up.pitch_scale = randf_range(0.99, 1.01)
			pick_up.play(0)
		
		collision_shape_2d.queue_free()


func _on_pick_up_finished():
	queue_free()
