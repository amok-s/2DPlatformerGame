extends StaticBody2D

var speed = -220

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * delta



func _on_core_body_entered(body):
	if (body.name == "TileMap"):
		queue_free()
	

func _on_blades_body_entered(body):
	if (body.name == "CharacterBody2D"):
		print ("Decrease player health")
		body.hit_by_plant()
		queue_free()
