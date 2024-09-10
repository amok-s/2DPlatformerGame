extends CharacterBody2D

@onready var bee = $".."
@onready var game_manager = %GameManager
var taking_damage = false
var player_spotted = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func sees_player():
	pass


func _on_collision_damage_body_entered(body):
	if body.name == "CharacterBody2D":
		var y_delta = get_node("DamageCollision").global_position.y - body.global_position.y
		var x_delta = body.global_position.x - get_node("DamageCollision").global_position.x
	
		if y_delta > 45:
			taking_damage = true
			print("pszczoła dead")
			body.velocity.y = -450
			$Death.play(0)
			await get_tree().create_timer(2).timeout
			queue_free()
		else:
			body.taking_damage = true
			body.game_manager.decrease_health()
			body.velocity.y = -320
			body.velocity.x = x_delta * 10
			await get_tree().create_timer(0.3).timeout
			body.taking_damage = false



func _on_player_detector_body_entered(body):
	if body.name == "CharacterBody2D":
		player_spotted = true


func _on_player_detector_body_exited(body):
	if body.name == "CharacterBody2D":
		await get_tree().create_timer(2.5).timeout
		player_spotted = false
