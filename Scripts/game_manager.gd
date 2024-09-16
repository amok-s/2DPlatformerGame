extends Node
@onready var game_manager = %GameManager
@onready var points_label = %PointsLabel
@onready var fruits_node = $"../Scene Objects/Collectables group"
@onready var blink = $"../Scene Objects/Blink"


@export var player : CharacterBody2D
@export var hearts : Array[Node]
@export var next_level : PackedScene
@export var chroma_chaos : PackedScene
@export var shockwave : PackedScene
@export var arrow : PackedScene
@export var FruitsLeftForArrowToShow : int
@export var sfx : PackedScene


var points = 0
var lives = 3
var fruits_count = 0
var fruits_amount
var arrow_count = 0
var current_arrow

func _ready():
	blink.hide()
	fruits_amount = fruits_node.get_child_count()

func add_point():
	points += 1
	if points == 10:
		add_health()
		points = 0

func add_fruit():
	fruits_count += 1
	points_label.text = "Fruits: " + str(fruits_count) + " / " + str(fruits_amount)
	if fruits_count > fruits_amount - FruitsLeftForArrowToShow - 1 and fruits_count != fruits_amount:
		arrow_timer()
	if fruits_count == fruits_amount:
		finish_level()
		

func _on_finish_finished():
	await get_tree().create_timer(0.1).timeout
	Engine.time_scale = 1
	get_tree().change_scene_to_packed(next_level)

func decrease_health():
	spawn_chroma_chaos(0.28)
	lives -= 1
	if lives > 0:
		get_node("../UI").ui_shake(0.2,5)
	for h in 3:
		if (h < lives):
			hearts[h].show()
		else:
			hearts[h].hide()
	if (lives == 0):
		var tween = get_tree().create_tween()
		tween.tween_property(%Camera2D, "zoom", Vector2(2.2, 2.6), 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		await get_tree().create_timer(0.75).timeout
		player_dead()

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
	spawn_shockwave()
	$"../UI".hide()
	Engine.time_scale = 0.6
	var tween = get_tree().create_tween()
	tween.tween_property(%Camera2D, "zoom", Vector2(2, 2), 3).set_ease(Tween.EASE_IN)
	var music = get_parent().get_node("BgMusic")
	if music:
		GlobalLevelManager.music_time = music.get_playback_position()

func spawn_chroma_chaos(time):
	var b = chroma_chaos.instantiate()
	get_parent().get_parent().add_child(b)
	await get_tree().create_timer(time).timeout
	b.queue_free()

func spawn_shockwave():
	var b = shockwave.instantiate()
	var camera = player.get_node("Camera2D")
	var offset = (player.position - camera.get_screen_center_position()) * camera.zoom / Vector2(get_window().size)
	var player_center = Vector2(0.5, 0.5) + offset
	player_center.x = (1.8 * player_center.x - 0.4)
	#b.position = camera.get_screen_center_position() * camera.zoom / Vector2(get_window().size)
	b.get_child(0).get_material().set_shader_parameter("center", player_center)
	get_parent().add_child(b)
	await get_tree().create_timer(0.8).timeout
	b.queue_free()

func spawn_arrow(last_fruit):
	if last_fruit == fruits_count:
		var b = arrow.instantiate()
		b.position = player.global_position
		get_parent().add_child(b)

func arrow_timer():
	var last_fruit = fruits_count
	await get_tree().create_timer(10).timeout
	spawn_arrow(last_fruit)

func spawn_blink():
	var offset = Vector2(blink.size.x / 2, blink.size.y /2)
	blink.position = player.position - offset
	blink.show()
	await get_tree().create_timer(0.02).timeout
	blink.hide()

func spawn_sfx(name, sfx_position : Vector2, rotation = 0, scale = Vector2(4,4)):
	var b = sfx.instantiate()
	b.position = sfx_position
	b.rotation_degrees = rotation
	b.scale = scale
	add_child(b)
	b.play_animation(name)

func player_dead():
	var music = get_parent().get_node("BgMusic")
	if music:
		GlobalLevelManager.music_time = music.get_playback_position()
	get_tree().reload_current_scene()

func showOutline(item):
	var shader = preload("res://shaders/outline.gdshader")
	pass
