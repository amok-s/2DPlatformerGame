extends Node
 
var levels : Array[String]

func _process(delta):
	if Input.is_action_just_pressed("save"):
		save_game()
		
	if Input.is_action_just_pressed("load"):
		load_game()

func save():
	var save_dict = {
	"fruits" : Stats.fruits_eaten,
	"deaths" : Stats.global_deaths,
	"mobs killed" : Stats.mobs_killed,
	"levels unlocked" : Stats.levels_unlocked,
	"arc 2": Stats.arc2_unlocked,
	"arc 3": Stats.arc3_unlocked,
	"mushroom": Stats.mushroom_killed,
	"plant" : Stats.plants_killed,
	"bee": Stats.bee_killed,
	"chameleon" : Stats.chameleon_killed,
	"bat" : Stats.bat_killed,
	"turtle" : Stats.turtle_bounced
	}
	return save_dict

func save_game():
	var save_game = FileAccess.open_encrypted_with_pass("user://savegame.save", FileAccess.WRITE, "not4u")
	
	var json_string = JSON.stringify(save())
	
	save_game.store_line(json_string)
	print("game saved")

func load_game():
	if !FileAccess.file_exists("user://savegame.save"):
		return
		
	var save_game = FileAccess.open_encrypted_with_pass("user://savegame.save", FileAccess.READ, "not4u")
	levels = []
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		for item in node_data["levels unlocked"]:
			levels.append(item)
		Stats.mobs_killed = node_data["mobs killed"]
		Stats.fruits_eaten = node_data["fruits"]
		Stats.global_deaths = node_data["deaths"]
		Stats.levels_unlocked = levels
		Stats.arc2_unlocked = node_data["arc 2"]
		Stats.arc3_unlocked = node_data["arc 3"]
		Stats.mushroom_killed = node_data["mushroom"]
		Stats.plants_killed = node_data["plant"]
		Stats.bee_killed = node_data["bee"]
		Stats.chameleon_killed = node_data["chameleon"]
		Stats.bat_killed = node_data["bat"]
		Stats.turtle_bounced = node_data["turtle"]
