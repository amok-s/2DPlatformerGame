extends Node
@onready var game_manager = %GameManager
@onready var points_label = %PointsLabel
@onready var pick_up = $PickUp
@onready var fruits_node = $"../Scene Objects/Collectables group"

@export var player : CharacterBody2D
@export var hearts : Array[Node]
@export var next_level : PackedScene


var points = 0
var lives = 3
var fruits_count = 0
var fruits_amount

func _ready():
	fruits_amount = fruits_node.get_child_count()

func add_point():
	points += 1
	print(points)

func add_fruit():
	fruits_count += 1
	points_label.text = "Fruits: " + str(points) + " / " + str(fruits_amount)
	if fruits_count == 10:
		add_health()
	if fruits_count == fruits_amount:
		finish_level()
		

func _on_finish_finished():
	await get_tree().create_timer(0.1).timeout
	Engine.time_scale = 1
	get_tree().change_scene_to_packed(next_level)

func decrease_health():
	lives -= 1
	print(lives)
	for h in 3:
		if (h < lives):
			hearts[h].show()
		else:
			hearts[h].hide()
	if (lives == 0):
		await get_tree().create_timer(0.65).timeout
		get_tree().reload_current_scene()

func add_health():
	if lives < 3:
		lives += 1
		$Healed.play(0)
	for h in 3:
		if (h < lives):
			hearts[h].show()
		else:
			hearts[h].hide()

func finish_level():
	$finish.play(0)
	Engine.time_scale = 0.6
	var tween = get_tree().create_tween()
	tween.tween_property(%Camera2D, "zoom", Vector2(2, 2), 3).set_ease(Tween.EASE_IN)

