extends RigidBody2D
@onready var game_manager = %GameManager
@onready var animated_sprite_2d = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		if (y_delta > -247):
			print (y_delta)
			print ("Destroy enemy")
			body.jump()
			animated_sprite_2d.play("hit")
			await get_tree().create_timer(0.35).timeout
			queue_free()
		else:
			print ("Decrease player health")
			game_manager.decrease_health()
			print (x_delta)
			if (x_delta < 600): #if player touch enemy from the left
				print ("w lewo")
				body.jump_side(-500) 
			else: #approaching ftom the right
				print ("w prawo") 
				body.jump_side(500)