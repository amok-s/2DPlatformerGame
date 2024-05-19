extends Node
@onready var game_manager = %GameManager
@onready var points_label = %PointsLabel
@onready var pick_up = $PickUp


var points = 0

func add_point():
	points += 1
	print(points)
	points_label.text = "Points: " + str(points)
	

