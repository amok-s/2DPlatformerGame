extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_damage_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var y_delta = (position.y - body.position.y)
		var x_delta = (body.position.x - position.x)
		body.take_damage(350 if x_delta > 0 else -350, -550)
