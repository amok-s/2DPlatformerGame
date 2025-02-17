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
@export var text_sfx : PackedScene

var loadingScreen = "res://scenes/loading_screen.tscn"

var points = 0
var lives = 3
var fruits_count = 0
var fruits_amount
var arrow_count = 0
var current_arrow
var chroma
var cant_die = false

func _ready():
	blink.hide()
	Engine.time_scale = 1
	fruits_amount = fruits_node.get_child_count()
	pauseBreak(1)
	Stats.lvl_unlock(get_parent().lvlname)
	SaveSystem.save_game()
	start_message()

func add_point():
	points += 1
	if points == 10:
		add_health()
		points = 0

func add_fruit():
	fruits_count += 1
	Stats.fruits_eaten += 1
	points_label.text = "Fruits: " + str(fruits_count) + " / " + str(fruits_amount)
	if fruits_count > fruits_amount - FruitsLeftForArrowToShow - 1 and fruits_count != fruits_amount:
		arrow_timer()
	if fruits_count == fruits_amount:
		finish_level()

func decrease_health():
	spawn_chroma_chaos(0.28)
	lives -= 1
	if lives > 0:
		player.outlineBlink()
		get_node("../UI").ui_shake(0.2,5)
	for h in 3:
		if (h < lives):
			hearts[h].play("full")
		else:
			hearts[h].play("broken")
	if (lives == 0) and !cant_die:
		GlobalLevelManager.pausable = false
		$"../UI/HeartsPanel".hide()
		$"../UI/CoinsPanel".hide()
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
			hearts[h].play("full")
		else:
			hearts[h].play("broken")

func finish_level():
	GlobalLevelManager.pausable = false
	checkArc()
	cant_die = true
	$finish.play(0)
	spawn_shockwave()
	$"../UI".hide()
	Engine.time_scale = 0.6
	var tween = get_tree().create_tween()
	tween.tween_property(%Camera2D, "zoom", Vector2(2, 2), 3).set_ease(Tween.EASE_IN)
	if !GlobalLevelManager.endOfArc:
		ResourceLoader.load_threaded_request(next_level.resource_path)
	else:
		GlobalLevelManager.nextLevelPath = next_level.resource_path
		ResourceLoader.load_threaded_request(loadingScreen)
		
func _on_finish_finished():
	await get_tree().create_timer(0.1).timeout
	
	var newScene = ResourceLoader.load_threaded_get(next_level.resource_path if GlobalLevelManager.endOfArc == false else loadingScreen)
	
	var music = get_parent().get_node("BgMusic")
	if music:
		GlobalLevelManager.music_time = music.get_playback_position()
	if GlobalLevelManager.endOfArc == true:
		GlobalLevelManager.currentArc = GlobalLevelManager.currentArc + 1
		get_tree().change_scene_to_packed(newScene)
	else:
		SceneTransition.change_scene(newScene)
	
func spawn_chroma_chaos(time):
	chroma = chroma_chaos.instantiate()
	get_parent().add_child(chroma)
	await get_tree().create_timer(time).timeout
	chroma.queue_free()

func spawn_shockwave():
	var b = shockwave.instantiate()
	var camera = player.get_node("Camera2D")
	var offset = (player.position - camera.get_screen_center_position()) * camera.zoom / Vector2(get_window().size)
	var player_center = Vector2(0.5, 0.5) + offset
	player_center.x = (1.8 * player_center.x - 0.4)
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

func spawn_sfx(sfx_name, sfx_position : Vector2, rotation = 0, scale = Vector2(4,4)):
	var b = sfx.instantiate()
	b.position = sfx_position
	b.rotation_degrees = rotation
	b.scale = scale
	add_child(b)
	b.play_animation(sfx_name)

func player_dead():
	GlobalLevelManager.death_count += 1
	Stats.global_deaths += 1
	var music = get_parent().get_node("BgMusic")
	if music:
		GlobalLevelManager.music_time = music.get_playback_position()
	if Engine.time_scale == 1:
		SceneTransition.level_restart()
	else:
		return

func pauseBreak(time):
	GlobalLevelManager.pausable = false
	await get_tree().create_timer(time).timeout
	GlobalLevelManager.pausable = true
	
func checkArc():
	if get_parent().lvlname == "lvl1_2":
		Stats.arc2_unlocked = true
	if get_parent().lvlname == "lvl2_2":
		Stats.arc3_unlocked = true

func spawn_text_sfx(sfx_name, sfx_position : Vector2, extra = null):
	if get_parent().show_text_sfx == true:
		var b = text_sfx.instantiate()
		b.position = sfx_position
		add_child(b)
		b.show_sfx(sfx_name, extra)

func start_message():
	await get_tree().create_timer(1.2).timeout
	spawn_text_sfx("start message", player.position, fruits_amount)
