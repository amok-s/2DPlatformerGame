extends RigidBody2D

@onready var game_manager = %GameManager


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		print ("hit by spikes")
		game_manager.decrease_health()
		var y_delta = (position.y - body.position.y) * 23
		var x_delta = (body.position.x - position.x) * 9
		if (y_delta > 620):
			body.hit_by_spikes(x_delta, -600)
		else:
			body.hit_by_spikes(x_delta, -350)
