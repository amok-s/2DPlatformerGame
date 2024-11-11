extends Node2D

@onready var game_manager = %GameManager

# Called when the node enters the scene tree for the first time.
func _ready():
	var children = $ClipRect/Labels.get_children()
	for child in children:
		child.hide()

func show_sfx(name, extra = null):
	match name:
		"bump":
			bump()
		"fruits left":
			fruits_left(extra)
		"pop":
			pop()
		"start message":
			start_message(extra)
		"enraged":
			enraged()
		"mlem":
			mlem()
		_:
			print("No sfx found")


func bump():
	$ClipRect/Labels/Bump.show()
	position += Vector2(randi_range(-20, 20), randi_range(-65, -75))
	$AnimationPlayer.play("bump")
	await get_tree().create_timer(0.1).timeout
	$AnimationPlayer.play("fade_out", 0.2)
	await get_tree().create_timer(0.4).timeout
	queue_free()
	
func fruits_left(extra):
	position += Vector2(randi_range(-8, 8), -5)
	z_index = 5
	$ClipRect/Labels/FruitsLeft.show()
	$ClipRect/Labels/FruitsLeft/Label.text = str(extra) + " left"
	$AnimationPlayer.play("move_up")
	await get_tree().create_timer(0.2).timeout
	$AnimationPlayer.play("fade_out", 0.2)
	await get_tree().create_timer(0.5).timeout
	queue_free()

func pop():
	z_index = 5
	position += Vector2(0, -25)
	position += Vector2(randi_range(-25,25), randi_range(-15, 25))
	$ClipRect/Labels/Pop.show()
	$AnimationPlayer.play("fade_out")
	await get_tree().create_timer(0.7).timeout
	queue_free()

func start_message(extra):
	position += Vector2(-95, -95)
	z_index = 5
	$ClipRect/Labels/StartMessage/Label.text = "collect " + str(extra) + " fruits"
	$AnimationPlayer.play_backwards("fade_out")
	await get_tree().create_timer(0.4).timeout
	$ClipRect/Labels/StartMessage.show()
	await get_tree().create_timer(0.2).timeout
	$AnimationPlayer.play("move_up", 0.6)
	await get_tree().create_timer(0.8).timeout
	$AnimationPlayer.play("fade_out")
	await get_tree().create_timer(0.4).timeout
	queue_free()
	
func enraged():
	position += Vector2(randi_range(-35, 0), randi_range(-8, 2))
	$ClipRect/Labels/Enraged.show()
	$AnimationPlayer.play("bump")
	await get_tree().create_timer(0.4).timeout
	$AnimationPlayer.play("fade_out", 0.3)
	await get_tree().create_timer(0.7).timeout
	queue_free()

func mlem():
	position += Vector2(randi_range(-20, 5), -20)
	$ClipRect/Labels/Mlem.show()
	$AnimationPlayer.play("bump")
	await get_tree().create_timer(0.2).timeout
	$AnimationPlayer.play("fade_out", 0.3)
	await get_tree().create_timer(0.7).timeout
	queue_free()
	
