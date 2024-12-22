extends Panel

@onready var tap_sound = $"../../TapSound"

var levels = []

func _ready():
	var nodes = get_children()
	for node in nodes:
		for level in node.get_child(3).get_children():
			levels.append(level)
	levels_unlock()
	arc_unlock()
	
func _process(delta):
	selection_menu_logic()

func level_selection():
	var last_level = Stats.levels_unlocked.back()
	for level in levels:
		if last_level == level.name:
			level.get_parent().get_parent().show()
			level.grab_focus()

func levels_unlock():
	for level in levels:
		if Stats.levels_unlocked.has(level.name):
			level.disabled = false

func arc_unlock():
	if Stats.arc2_unlocked:
		$Arc1/RightArrow.modulate = Color("cbff74")
		$Arc2/LeftArrow.modulate = Color("cbff74")
		
	if Stats.arc3_unlocked:
		$Arc2/RightArrow.modulate = Color("cbff74")
		$Arc3/LeftArrow.modulate = Color("cbff74")

func selection_menu_logic():
	if Input.is_action_just_pressed("right"):
		if $Arc1.is_visible_in_tree() and Stats.arc2_unlocked:
			$Arc1.hide()
			$Arc2.show()
			$Arc2/Levels/lvl2_0.grab_focus()
		elif $Arc2.is_visible_in_tree() and Stats.arc3_unlocked:
			$Arc2.hide()
			$Arc3.show()
			$Arc3/Levels/lvl3_0.grab_focus()
			
	if Input.is_action_just_pressed("left"):
		if $Arc2.is_visible_in_tree():
			$Arc2.hide()
			$Arc1.show()
			$Arc1/Levels/lvl1_0.grab_focus()
		elif $Arc3.is_visible_in_tree():
			$Arc3.hide()
			$Arc2.show()
			$Arc2/Levels/lvl2_0.grab_focus()

func _on_lvl_1_0_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		GlobalLevelManager.currentArc = 1
		GlobalLevelManager.nextLevelPath = "res://scenes/levels/1st Arc/1_0/level_1_0.tscn"
		var loadingScreen = load("res://scenes/loading_screen.tscn")
		get_tree().change_scene_to_packed(loadingScreen)

func _on_lvl_1_1_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		GlobalLevelManager.currentArc = 1
		GlobalLevelManager.nextLevelPath = "res://scenes/levels/1st Arc/1_1/level_1_1.tscn"
		var loadingScreen = load("res://scenes/loading_screen.tscn")
		get_tree().change_scene_to_packed(loadingScreen)

func _on_lvl_1_2_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		GlobalLevelManager.currentArc = 1
		GlobalLevelManager.nextLevelPath = "res://scenes/levels/1st Arc/1_2/level_1_2.tscn"
		var loadingScreen = load("res://scenes/loading_screen.tscn")
		get_tree().change_scene_to_packed(loadingScreen)

func _on_lvl_2_0_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		GlobalLevelManager.currentArc = 2
		GlobalLevelManager.nextLevelPath = "res://scenes/levels/2nd Arc/2_0/level_2_0.tscn"
		var loadingScreen = load("res://scenes/loading_screen.tscn")
		get_tree().change_scene_to_packed(loadingScreen)

func _on_lvl_2_1_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		GlobalLevelManager.currentArc = 2
		GlobalLevelManager.nextLevelPath = "res://scenes/levels/2nd Arc/2_1/level_2_1.tscn"
		var loadingScreen = load("res://scenes/loading_screen.tscn")
		get_tree().change_scene_to_packed(loadingScreen)

func _on_lvl_2_2_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		GlobalLevelManager.currentArc = 2
		GlobalLevelManager.nextLevelPath = "res://scenes/levels/2nd Arc/2_2/level_2_2.tscn"
		var loadingScreen = load("res://scenes/loading_screen.tscn")
		get_tree().change_scene_to_packed(loadingScreen)

func _on_lvl_3_0_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		GlobalLevelManager.currentArc = 3
		GlobalLevelManager.nextLevelPath = "res://scenes/levels/3rd Arc/3_0/level_3_0.tscn"
		var loadingScreen = load("res://scenes/loading_screen.tscn")
		get_tree().change_scene_to_packed(loadingScreen)

func _on_lvl_3_1_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		GlobalLevelManager.currentArc = 3
		GlobalLevelManager.nextLevelPath = "res://scenes/levels/3rd Arc/3_1/level3_1.tscn"
		var loadingScreen = load("res://scenes/loading_screen.tscn")
		get_tree().change_scene_to_packed(loadingScreen)

func _on_lvl_3_2_pressed():
	tap_sound.play(0)
	if (tap_sound.finished):
		GlobalLevelManager.currentArc = 3
		GlobalLevelManager.nextLevelPath = "res://scenes/levels/3rd Arc/3_2/level3_2.tscn"
		var loadingScreen = load("res://scenes/loading_screen.tscn")
		get_tree().change_scene_to_packed(loadingScreen)

func unlock_all_levels():
	for level in levels:
		level.disabled = false
		Stats.lvl_unlock(level.name)
	levels_unlock()
	Stats.arc2_unlocked = true
	Stats.arc3_unlocked = true
	arc_unlock()









