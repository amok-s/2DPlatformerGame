extends CharacterBody2D

var taking_damage = false
var player_spotted = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var speed : int = 65
var path
var player
var chase_position

func _ready():
	if get_parent().name == "PathFollow2D":
		path = get_parent()

func _process(delta):
	move_and_slide()

func _on_player_detector_body_entered(body):
	pass
	#if body.name == "CharacterBody2D":
		#player = body
		#if player_spotted == false:
			#$AnimationPlayer.play("rage")
			#$Rage.play(0)
			#await get_tree().create_timer(0.4).timeout
			#$AnimationPlayer.play_backwards("rage")
			#chase_position = global_position
			#player_spotted = true
			#player_spotted_timer()
		
func _on_damage_collision_body_entered(body):
	if body.name == "CharacterBody2D":
		var y_delta = get_node("DamageCollision").global_position.y - body.global_position.y
		var x_delta = body.global_position.x - get_node("DamageCollision").global_position.x
	
		if y_delta > 30: #bee killed
			taking_damage = true
			Stats.bee_killed += 1
			var bee_position = global_position
			get_node("../%GameManager").spawn_sfx("dust_2", bee_position + Vector2(10, 0))
			body.velocity.y = -550
			body.game_manager.spawn_blink()
			$Death.play(0)
			await get_tree().create_timer(2).timeout
			queue_free()
		else:
			body.take_damage(x_delta * 10, -320)

func player_spotted_timer():
	await get_tree().create_timer(randi_range(2.7, 3.7)).timeout
	player_spotted = false
