extends Node
@onready var game_manager = %GameManager
@onready var points_label = %PointsLabel
@onready var fruits_node = $"../Scene Objects/Collectables group"

@export var player : CharacterBody2D
@export var hearts : Array[Node]
@export var next_level : PackedScene
@export var chroma_chaos : PackedScene
@export var shockwave : PackedScene
@export var arrow : PackedScene


var points = 0
var lives = 3
var fruits_count = 0
var fruits_amount
var arrow_count = 0
var current_arrow
var a_timer = true

func _ready():
	fruits_amount = fruits_node.get_child_count()

func add_point():
	points += 1
	if points == 10:
		add_health()
		points = 0

func add_fruit():
	fruits_count += 1
	points_label.text = "Fruits: " + str(fruits_count) + " / " + str(fruits_amount)
	if fruits_count > fruits_amount - 4 and fruits_count != fruits_amount and a_timer == true:
		arrow_timer()
	if fruits_count == fruits_amount:
		finish_level()
		

func _on_finish_finished():
	await get_tree().create_timer(0.1).timeout
	Engine.time_scale = 1
	get_tree().change_scene_to_packed(next_level)

func decrease_health():
	if lives != 1:
		get_node("../UI").ui_shake(0.2,5)
	lives -= 1
	spawn_chroma_chaos(0.28)
	for h in 3:
		if (h < lives):
			hearts[h].show()
		else:
			hearts[h].hide()
	if (lives == 0):
		await get_tree().create_timer(0.75).timeout
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
	spawn_chroma_chaos(0.3)
	spawn_shockwave()
	Engine.time_scale = 0.6
	var tween = get_tree().create_tween()
	tween.tween_property(%Camera2D, "zoom", Vector2(2, 2), 3).set_ease(Tween.EASE_IN)

func spawn_chroma_chaos(time):
	var b = chroma_chaos.instantiate()
	get_parent().add_child(b)
	await get_tree().create_timer(time).timeout
	b.queue_free()

func spawn_shockwave():
	var b = shockwave.instantiate ()
	var camera = player.get_node("Camera2D")
	var offset = (player.position - camera.get_screen_center_position()) * camera.zoom / Vector2(get_window().size)
	var player_center = Vector2(0.5, 0.5) + offset
	#var player_center = Vector2(0.5, 0.5) + offset
	player_center.x = (1.8 * player_center.x - 0.4)
	b.get_material().set_shader_parameter("center", player_center)
	get_parent().add_child(b)
	await get_tree().create_timer(0.8).timeout
	b.queue_free()


func spawn_arrow():
	var b = arrow.instantiate()
	b.position = player.global_position
	get_parent().add_child(b)

func arrow_timer():
	var d = fruits_count
	a_timer = false
	await get_tree().create_timer(10).timeout
	if d == fruits_count and fruits_count != fruits_amount:
		spawn_arrow()
		a_timer = true
