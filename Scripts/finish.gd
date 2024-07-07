extends Area2D

@export var target_level : PackedScene
@onready var level_finish = $LevelFinish
@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D


func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		level_finish.play(0)
		sprite_2d.animation = "win"
		collision_shape_2d.queue_free()

func _on_level_finish_finished():
	get_tree().change_scene_to_packed(target_level)
