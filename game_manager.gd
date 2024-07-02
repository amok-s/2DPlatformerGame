extends Node
@onready var game_manager = %GameManager
@onready var points_label = %PointsLabel
@onready var pick_up = $PickUp
@export var hearts : Array[Node]




var points = 0
var lives = 3

func add_point():
	points += 1
	print(points)
	points_label.text = "Points: " + str(points)
	
func decrease_health():
	lives -= 1
	print(lives)
	for h in 3:
		if (h < lives):
			hearts[h].show()
		else:
			hearts[h].hide()
	if (lives == 0):
		await get_tree().create_timer(0.5).timeout
		get_tree().reload_current_scene()
	

