extends CharacterBody2D
@onready var player = $"../Scene Objects/CharacterBody2D"
@onready var fruits_group = $"../Scene Objects/Collectables group"
@onready var game_manager = $"../GameManager"


var speed = 180
var fruits: Array[Node]
var current_fruit
var counter = 0
var fruit_count
var target: Vector2

func _ready():
	fruit_count = game_manager.fruits_count
	fruits = fruits_group.get_children(false)
	current_fruit = fruits[0]
	for i in fruits:
		if player.position.distance_to(fruits[counter].position) < player.position.distance_to(current_fruit.position):
			current_fruit = fruits[counter]
		counter += 1
	target = current_fruit.position

func _process(delta):
	if fruit_count < game_manager.fruits_count:
		queue_free()
	look_at(target + Vector2(-25, 75))
	calculate_velocity()
	move_and_slide()

func calculate_velocity():
	var distance_to_player = 20
	var player_position = player.position - Vector2(0, 95)
	
	if position.distance_to(player_position) > distance_to_player:
		var direction = (player_position - position).normalized()
		velocity = direction * speed
		velocity.x *= 1.3
	else: 
		velocity.x += 0.5
		velocity.y -= 12


