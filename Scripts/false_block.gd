extends Node2D

var bottomGoDown = false
var topGoDown = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	$MainBody/Sprite.animation = "idle"
	$TopPart.hide()
	$BottomPart.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if bottomGoDown == true:
		$BottomPart.move_and_slide()
		$BottomPart.velocity.y += gravity * delta
		
	if topGoDown == true:
		$TopPart.move_and_slide()
		$TopPart.velocity.y += gravity * delta
	

func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D":
		$AnimationPlayer.play("collapse")
		MainBodyCollapse()
		

func MainBodyCollapse():
		$MainBody/Area2D/CollisionShape2D.queue_free()
		$MainBody/Sprite.play("hit")
		await get_tree().create_timer(0.3).timeout
		$MainBody/Sprite.animation = "idle"
		$TopPart.show()
		$BottomPart.show()
		$MainBody.queue_free()
		BottomCollapse()

func BottomCollapse():
	await get_tree().create_timer(0.2).timeout
	$BottomPart/Sprite.play("default")
	await get_tree().create_timer(0.3).timeout
	$BottomPart/Sprite.pause()
	$BottomPart/Sprite.frame = 2
	bottomGoDown = true
	TopCollapse()

func TopCollapse():
	await get_tree().create_timer(0.2).timeout
	$TopPart/Sprite.play("default")
	bottomGoDown = false
	$BottomPart.queue_free()
	await get_tree().create_timer(0.3).timeout
	$TopPart/Sprite.pause()
	$TopPart/Sprite.frame = 2
	topGoDown = true
	await get_tree().create_timer(0.3).timeout
	$TopPart/CollisionShape2D.queue_free()
	await get_tree().create_timer(3).timeout
	topGoDown = false
	$TopPart.queue_free()
	queue_free()
