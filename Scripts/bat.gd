extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var marker_node : Node

var scale_switch = false
var taking_damage = false

func _ready():
	pass

func _physics_process(delta):
	if velocity.x > 0 && !scale_switch:
		scale_switch = true
		$sprite.scale.x = -$sprite.scale.x
		
	if velocity.x < 0 && scale_switch:
		scale_switch = false
		$sprite.scale.x = -$sprite.scale.x
		
	move_and_slide()
	

func _on_damage_collision_body_entered(body):
	if body.name == "CharacterBody2D":
		var y_delta = global_position.y - body.global_position.y
		var x_delta = body.global_position.x - global_position.x
		
		if y_delta > 30: #bat killed
				taking_damage = true
				Stats.bat_killed += 1
				Stats.mobs_killed += 1
				get_node("../%GameManager").spawn_sfx("dust_2", global_position + Vector2(8, 0))
				body.velocity.y = -550
				body.game_manager.spawn_blink()
				$Death.play(0)
				await get_tree().create_timer(2).timeout
				queue_free()
		else:
			body.take_damage(x_delta * 13, -320)

