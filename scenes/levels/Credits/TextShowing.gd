extends Node2D

@onready var text_group = $"../Vines/Further/Text"
@onready var animation_player = $"../Vines/Further/AnimationPlayer"

var A1_trigger = false
var A2_trigger = false

func offset_tween(node, time : float, offset : Vector2):
	var tween = get_tree().create_tween()
	var target_offset = node.position + offset
	tween.set_parallel()
	tween.tween_property(node, "position", target_offset, time)
	tween.set_trans(Tween.TRANS_CUBIC)

func fade_tween(node, time : float, fade_in : bool = true):
	var modulate_val
	if fade_in:
		node.modulate = Color(1, 1, 1, 0)
		modulate_val = Color(1, 1, 1)
	else:
		node.modulate = Color(1, 1, 1)
		modulate_val = Color(1, 1, 1, 0)
	
	node.show()
	var tween = get_tree().create_tween()
	
	tween.tween_property(node, "modulate", modulate_val, time)
	tween.set_parallel()
	tween.set_trans(Tween.TRANS_CUBIC)

func _ready():
	for child in text_group.get_children(): 
		child.hide()

func _process(delta):
	pass

func DeathCount():
	var text = text_group.get_node("A2_DeathCount")
	for child in text.get_children():
		child.hide()
		text.show()
	
	text.get_node("DeathCount").append_text("you only died [color=green]%s[/color] times..." % [Stats.global_deaths])

	
	fade_tween(text.get_node("OpeningText"), 0.7)
	offset_tween(text.get_node("OpeningText"), 1, Vector2(0, - 40))
	await get_tree().create_timer(1.4).timeout
	fade_tween(text.get_node("OpeningText"), 0.7, false)
	await get_tree().create_timer(0.5).timeout
	fade_tween(text.get_node("DeathCount"), 0.7)
	offset_tween(text.get_node("DeathCount"), 1, Vector2(0, - 40))

#opening text and congratulations
func _on_area_01_body_entered(body):
	if !A1_trigger and body.name == "CharacterBody2D":
		A1_trigger = true
		var text = text_group.get_node("A1_Congratulations")
		for child in text.get_children():
			child.hide()
		text.show()
		fade_tween(text.get_node("OpeningText"), 0.7)
		offset_tween(text.get_node("OpeningText"), 1, Vector2(0, -40))
		await get_tree().create_timer(1.5).timeout
		fade_tween(text.get_node("OpeningText"), 0.7, false)
		fade_tween(text.get_node("OpeningText2"), 0.7)
		offset_tween(text.get_node("OpeningText2"), 1, Vector2(0, -40))
		await get_tree().create_timer(2).timeout
		fade_tween(text.get_node("OpeningText2"), 0.7, false)
		await get_tree().create_timer(2).timeout
		$Area_01/TileMap2.queue_free()
		

func _on_area_02_body_entered(body):
	if !A2_trigger and body.name == "CharacterBody2D":
		A2_trigger = true
		await get_tree().create_timer(2).timeout
		DeathCount()
