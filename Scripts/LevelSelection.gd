extends Panel

var levels = []
var nodes 

func _ready():
	nodes = get_children()
	for node in nodes:
		for level in node.get_child(3).get_children():
			levels.append(level)
	
func _process(delta):
	pass

func check_level_progress():
	pass

func level_selection():
	var last_level = Stats.levels_unlocked.back()
	print(last_level)
	for node in nodes:
		print(node.name)
	for level in levels:
		if last_level == level.name:
			level.grab_focus()



func _on_lvl_1_0_pressed():
	print("wcisnieto")
