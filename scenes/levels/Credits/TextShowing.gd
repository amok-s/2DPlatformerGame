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
	
func modulate_tween(node, time : float, color):
	var tween = get_tree().create_tween()
	tween.tween_property(node, "modulate", color, time)
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
	
	text.get_node("DeathCount").append_text("you only died [wave amp=50.0 freq=5.0 connected=1][color=magenta]%s times...[/color][/wave]" % [Stats.global_deaths])

	
	fade_tween(text.get_node("OpeningText"), 0.7)
	offset_tween(text.get_node("OpeningText"), 1, Vector2(0, - 40))
	await get_tree().create_timer(1.4).timeout
	fade_tween(text.get_node("OpeningText"), 0.7, false)
	await get_tree().create_timer(0.5).timeout
	fade_tween(text.get_node("DeathCount"), 0.7)
	offset_tween(text.get_node("DeathCount"), 1, Vector2(0, - 40))
	await get_tree().create_timer(3.4).timeout
	fade_tween(text.get_node("DeathCount"), 0.7, false)
	await get_tree().create_timer(0.5).timeout

func FruitsCount():
	var text = text_group.get_node("A3_FruitsCount")
	for child in text.get_children():
		child.hide()
		text.show()
	
	text.get_node("FruitsCount").append_text("have eaten [wave amp=50.0 freq=5.0 connected=1][color=magenta]%s fruits...[/color][/wave]" % [Stats.fruits_eaten])

	
	fade_tween(text.get_node("OpeningText"), 0.7)
	offset_tween(text.get_node("OpeningText"), 1, Vector2(0, - 40))
	await get_tree().create_timer(1.4).timeout
	fade_tween(text.get_node("OpeningText"), 0.7, false)
	await get_tree().create_timer(0.5).timeout
	fade_tween(text.get_node("FruitsCount"), 0.7)
	offset_tween(text.get_node("FruitsCount"), 1, Vector2(0, - 40))
	await get_tree().create_timer(3.4).timeout
	fade_tween(text.get_node("FruitsCount"), 0.7, false)
	await get_tree().create_timer(0.9).timeout
	fade_tween(text.get_node("Noice"), 0.7)
	offset_tween(text.get_node("Noice"), 1, Vector2(0, - 40))
	await get_tree().create_timer(2).timeout
	fade_tween(text.get_node("Noice"), 0.7, false)

func MobCount():
	var text = text_group.get_node("A4_MobCount")
	for child in text.get_children():
		child.hide()
		text.show()
	
	text.get_node("MobCount").append_text("you killed [shake rate=20.0 level=5 connected=1][color=magenta]%s mobs...[/color][/shake]" % [Stats.mobs_killed])
	text.get_node("Mushroom").append_text("[shake rate=20.0 level=5 connected=1][color=magenta]%s mushrooms...[/color][/shake]" % [Stats.mushroom_killed])
	text.get_node("Chameleon").append_text("[shake rate=20.0 level=5 connected=1][color=magenta]%s chameleons...[/color][/shake]" % [Stats.chameleon_killed])
	text.get_node("Plant").append_text("[shake rate=20.0 level=5 connected=1][color=magenta]%s plants...[/color][/shake]" % [Stats.plants_killed])
	text.get_node("Bee").append_text("[shake rate=20.0 level=5 connected=1][color=magenta]%s bees...[/color][/shake]" % [Stats.bee_killed])
	text.get_node("Bat").append_text("[shake rate=20.0 level=5 connected=1][color=magenta]%s bats...[/color][/shake]" % [Stats.bat_killed])
	text.get_node("Turtle").append_text("bounced on [wave amp=50.0 freq=5.0 connected=1][color=magenta]%s turtles...[/color][/wave]" % [Stats.turtle_bounced])


	fade_tween(text.get_node("OpeningText"), 0.7)
	offset_tween(text.get_node("OpeningText"), 1, Vector2(0, - 40))
	await get_tree().create_timer(1.4).timeout
	fade_tween(text.get_node("OpeningText"), 0.7, false)
	
	await get_tree().create_timer(0.5).timeout
	fade_tween(text.get_node("MobCount"), 0.7)
	offset_tween(text.get_node("MobCount"), 1, Vector2(0, - 40))
	await get_tree().create_timer(3.4).timeout
	fade_tween(text.get_node("MobCount"), 0.7, false)
	
	await get_tree().create_timer(0.9).timeout
	fade_tween(text.get_node("Including"), 0.7)
	offset_tween(text.get_node("Including"), 1, Vector2(0, - 40))
	await get_tree().create_timer(2).timeout
	fade_tween(text.get_node("Including"), 0.7, false)
	
	await get_tree().create_timer(0.9).timeout
	fade_tween(text.get_node("Mushroom"), 0.7)
	offset_tween(text.get_node("Mushroom"), 1, Vector2(0, - 40))
	await get_tree().create_timer(0.6).timeout
	fade_tween(text.get_node("Bee"), 0.7)
	offset_tween(text.get_node("Bee"), 1, Vector2(0, - 40))
	await get_tree().create_timer(0.4).timeout
	fade_tween(text.get_node("Chameleon"), 0.7)
	offset_tween(text.get_node("Chameleon"), 1, Vector2(0, - 40))
	await get_tree().create_timer(0.6).timeout
	fade_tween(text.get_node("Plant"), 0.7)
	offset_tween(text.get_node("Plant"), 1, Vector2(0, - 40))
	await get_tree().create_timer(0.8).timeout
	fade_tween(text.get_node("Bat"), 0.7)
	offset_tween(text.get_node("Bat"), 1, Vector2(0, - 40))
	await get_tree().create_timer(1.4).timeout
	
	fade_tween(text.get_node("Bat"), 0.7, false)
	fade_tween(text.get_node("Plant"), 0.7, false)
	fade_tween(text.get_node("Chameleon"), 0.7, false)
	fade_tween(text.get_node("Bee"), 0.7, false)
	fade_tween(text.get_node("Mushroom"), 0.7, false)
	
	await get_tree().create_timer(1.3).timeout
	fade_tween(text.get_node("Also"), 0.7)
	offset_tween(text.get_node("Also"), 1, Vector2(0, - 40))
	await get_tree().create_timer(1.5).timeout
	fade_tween(text.get_node("Also"), 0.7, false)
	
	await get_tree().create_timer(1.2).timeout
	fade_tween(text.get_node("Turtle"), 0.7)
	offset_tween(text.get_node("Turtle"), 1, Vector2(0, - 40))
	await get_tree().create_timer(1.5).timeout
	fade_tween(text.get_node("Turtle"), 0.7, false)
	
	await get_tree().create_timer(1.5).timeout
	fade_tween(text.get_node("NotBad"), 0.7)
	offset_tween(text.get_node("NotBad"), 1, Vector2(0, - 40))
	await get_tree().create_timer(1.5).timeout
	fade_tween(text.get_node("NotBad"), 0.7, false)

func FinishText():
	var text = text_group.get_node("A5_Finish")
	for child in text.get_children():
		child.hide()
		text.show()
		
	fade_tween(text.get_node("OpeningText"), 0.7)
	offset_tween(text.get_node("OpeningText"), 1, Vector2(0, - 40))
	await get_tree().create_timer(1.4).timeout
	fade_tween(text.get_node("OpeningText"), 0.7, false)
	await get_tree().create_timer(0.5).timeout
	
	fade_tween(text.get_node("ForWhat"), 1.2)
	offset_tween(text.get_node("ForWhat"), 1.4, Vector2(0, - 40))
	await get_tree().create_timer(2.5).timeout
	fade_tween(text.get_node("ForWhat"), 0.7, false)
	await get_tree().create_timer(0.5).timeout
	
	fade_tween(text.get_node("Money"), 0.7)
	offset_tween(text.get_node("Money"), 1, Vector2(0, - 40))
	await get_tree().create_timer(0.8).timeout
	fade_tween(text.get_node("Fame"), 0.7)
	offset_tween(text.get_node("Fame"), 1, Vector2(0, - 40))
	await get_tree().create_timer(2).timeout
	
	fade_tween(text.get_node("Money"), 0.7, false)
	fade_tween(text.get_node("Fame"), 0.7, false)
	await get_tree().create_timer(0.5).timeout
	
	fade_tween(text.get_node("WorthIt"), 0.7)
	offset_tween(text.get_node("WorthIt"), 1, Vector2(0, - 40))
	await get_tree().create_timer(2.5).timeout
	fade_tween(text.get_node("WorthIt"), 0.7, false)

func SceneryChange():
	var bg = $"../WorldBoundary/ForestBackground"
	var tween = get_tree().create_tween()
	tween.tween_property(bg.get_node("CanvasModulate"), "color", Color(0.984, 0.416, 0.541), 0.7)
	tween.set_parallel()
	tween.set_trans(Tween.TRANS_CUBIC)

	modulate_tween(bg.get_node("Sky"), 0.7, Color(0.996, 0.647, 1.4))
	modulate_tween(bg.get_node("Back"), 0.7, Color(0.996, 0.529, 1.6))
	modulate_tween(bg.get_node("BackMiddle"), 0.7, Color(1, 0.714, 1.8))
	
	await get_tree().create_timer(0.8).timeout
	
	var dust = $"../ShinyDust"
	var dust_tween = get_tree().create_tween()
	dust_tween.tween_property(dust, "amount_ratio", 1, 4)
	dust_tween.set_ease(Tween.EASE_IN_OUT)
	
	var god_rays = $"../GodRays/ColorRect2".get_material()
	var god_rays_tween = get_tree().create_tween()
	god_rays_tween.tween_property(god_rays, "shader_parameter/color", Color(1, 0.176, 0, 0.8), 3.4)
	god_rays_tween.set_ease(Tween.EASE_IN_OUT)
	
	
	

func Credits():
	$"../CameraChanges".cameraChangeZoom(Vector2(1, 1), 2.4)
	await get_tree().create_timer(1.5).timeout
	await SceneryChange()
	
	var text = text_group.get_node("A6_Credits")
	for child in text.get_children():
		child.hide()
		text.show()
	
	fade_tween(text.get_node("Logo"), 0.7)
	offset_tween(text.get_node("Logo"), 1, Vector2(0, - 40))
	await get_tree().create_timer(0.5).timeout
	
	fade_tween(text.get_node("Author"), 0.7)
	offset_tween(text.get_node("Author"), 1, Vector2(0, - 40))
	await get_tree().create_timer(3.5).timeout
	fade_tween(text.get_node("Author"), 0.7, false)
	await get_tree().create_timer(0.5).timeout
	
	fade_tween(text.get_node("Assets"), 0.7)
	offset_tween(text.get_node("Assets"), 1, Vector2(0, - 40))
	await get_tree().create_timer(5).timeout
	fade_tween(text.get_node("Assets"), 0.7, false)
	await get_tree().create_timer(0.5).timeout
	
	ResourceLoader.load_threaded_request(%GameManager.next_level.resource_path)
	
	fade_tween(text.get_node("Audio"), 0.7)
	offset_tween(text.get_node("Audio"), 1, Vector2(0, - 40))
	await get_tree().create_timer(5).timeout
	fade_tween(text.get_node("Audio"), 0.7, false)
	await get_tree().create_timer(0.5).timeout
	
	fade_tween(text.get_node("Tutorials"), 0.7)
	offset_tween(text.get_node("Tutorials"), 1, Vector2(0, - 40))
	await get_tree().create_timer(5).timeout
	fade_tween(text.get_node("Tutorials"), 0.7, false)
	await get_tree().create_timer(0.5).timeout
	
	fade_tween(text.get_node("Support"), 0.7)
	offset_tween(text.get_node("Support"), 1, Vector2(0, - 40))
	await get_tree().create_timer(5).timeout
	fade_tween(text.get_node("Logo"), 0.7, false)
	fade_tween(text.get_node("Support"), 0.7, false)
	await get_tree().create_timer(0.5).timeout
	
	fade_tween(text.get_node("Thanks"), 0.7)
	offset_tween(text.get_node("Thanks"), 1, Vector2(0, - 40))
	await get_tree().create_timer(5).timeout
	
func Finish():
	var vignette = $"../../Vignette/ColorRect".get_material()
	var tween = get_tree().create_tween()
	tween.tween_property(vignette, "shader_parameter/outerRadius", 0, 6)
	var tween_2 = get_tree().create_tween()
	tween_2.tween_property(vignette, "shader_parameter/MainAlpha", 1, 5)
	
	await get_tree().create_timer(7).timeout
	
	var newScene = ResourceLoader.load_threaded_get(%GameManager.next_level.resource_path)
	SceneTransition.change_scene(newScene)
	
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
		%Camera2D.limit_left = 0
		var tween = get_tree().create_tween()
		tween.tween_property(%Camera2D, "limit_left", 246, 5)
		tween.set_ease(Tween.EASE_IN_OUT)
		await get_tree().create_timer(2).timeout
		await DeathCount()
		await FruitsCount()
		await MobCount()
		await FinishText()
		await Credits()
		Finish()
