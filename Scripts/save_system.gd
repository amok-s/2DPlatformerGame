extends Node
 
var levels : Array[String]
var settings

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
		var _parse_result = json.parse(json_string)
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

func save_config():
	var config_file = FileAccess.open_encrypted_with_pass("user://config.save", FileAccess.WRITE, "not4u")
	var config = Stats.current_options
	var json_string = JSON.stringify(config)
	
	config_file.store_line(json_string)
	print("config saved")

func load_config():
	if !FileAccess.file_exists("user://config.save"):
		return
	
	var saved_config = FileAccess.open_encrypted_with_pass("user://config.save", FileAccess.READ, "not4u")
	while saved_config.get_position() < saved_config.get_length():
		var json_string = saved_config.get_line()
		var json = JSON.new()
		var _parse_result = json.parse(json_string)
		var node_data = json.get_data()
		settings = node_data
		print(settings)
		
		var full_screen = settings["full screen"]
		if full_screen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
		var music_volume = settings["music volume"]
		AudioServer.set_bus_volume_db(1, music_volume)
		
		var master_volume = settings["master volume"]
		AudioServer.set_bus_volume_db(0, master_volume)

func delete_progress():
	if !FileAccess.file_exists("user://savegame.save"):
		print("file does not exists")
		return
	
	else:
		DirAccess.remove_absolute("user://savegame.save")
		return
