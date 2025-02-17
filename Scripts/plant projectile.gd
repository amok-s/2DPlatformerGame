extends StaticBody2D

var speed = -250

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * delta

func _on_core_body_entered(body):
	if (body.name != "CharacterBody2D"):
		queue_free()
	


func _on_blades_body_entered(body):
	if (body.name == "CharacterBody2D"):
		body.take_damage(0, -600)
		queue_free()
