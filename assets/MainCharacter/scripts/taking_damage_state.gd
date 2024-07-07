extends State
class_name PlayerTakingDamage

@export var being_hit_sound : AudioStreamPlayer
@export var dead_sound : AudioStreamPlayer
@export var player : CharacterBody2D
@export var sprite : AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func Enter():
	if (player.game_manager.lives == 0):
		player.set_physics_process(false) 
		player.sides_input_blockage = true
		player.taking_damage = true
		sprite.play("dead")
		dead_sound.play(0)
		await get_tree().create_timer(0.3).timeout
		sprite.hide()
	else:
		being_hit_sound.play(0)
		sprite.play("hit")
		player.sides_input_blockage = true
		player.jump_input_blockage = true
		await get_tree().create_timer(0.3).timeout
		player.sides_input_blockage = false
		player.jump_input_blockage = false
		
	
	
	pass # Replace with function body.

func Update(_delta:float):
	if player.taking_damage == false:
		state_transition.emit(self, "Movement")
	
	


func Exit():
	pass
