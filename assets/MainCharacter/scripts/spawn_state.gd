extends State
class_name PlayerSpawn

@export var appear_sound : AudioStreamPlayer
@export var player : CharacterBody2D
@export var sprite : AnimatedSprite2D
@export var appearing : PackedScene


# Called when the node enters the scene tree for the first time.
func Enter():
	var original_camera = player.get_node("Camera2D").zoom
	player.get_node("Camera2D").zoom = Vector2(3,3.25)
	var tween = get_tree().create_tween()
	tween.tween_property(player.get_node("Camera2D"), "zoom", Vector2(original_camera), 0.8).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	
	
	sprite.hide()
	player.gravity = 0
	player.sides_input_blockage = true
	player.jump_input_blockage = true
	var appearing_node = appearing.instantiate(0)
	appearing_node.position = player.position
	get_parent().add_child(appearing_node)
	await get_tree().create_timer(0.68).timeout
	appear_sound.play(0)
	appearing_node.queue_free()
	player.gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	sprite.show()
	player.sides_input_blockage = false
	player.jump_input_blockage = false
	pass 

func Update(_delta:float):
	state_transition.emit(self, "Movement")
	
	


func Exit():
	pass
