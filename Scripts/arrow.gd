extends CharacterBody2D
@onready var player = $"../Scene Objects/CharacterBody2D"
@onready var fruits_group = $"../Scene Objects/Collectables group"


var speed = 140
var fruits: Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	



func _process(delta):
	fruits = fruits_group.get_children(false)
	look_at(fruits[0].position + Vector2(0, 95))
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


