extends Node

var global_deaths : int = 0
var fruits_eaten : int = 0
var mobs_killed : int = 0

var levels_unlocked: Array[String]

var arc2_unlocked = false
var arc3_unlocked = false

var mushroom_killed : int = 0
var plants_killed : int = 0
var bee_killed : int = 0
var chameleon_killed : int = 0
var bat_killed : int = 0
var turtle_bounced : int = 0

var defualt_options = {"master volume" : 0, "music volume": 0, "full screen" : false}
var current_options = {"master volume" : 0, "music volume": 0, "full screen" : false}

func restart():
	global_deaths = 0
	fruits_eaten = 0
	mobs_killed = 0
	
	levels_unlocked = []
	
	arc2_unlocked = false
	arc3_unlocked = false
	
	mushroom_killed = 0
	plants_killed = 0
	bee_killed = 0
	chameleon_killed = 0
	bat_killed = 0
	turtle_bounced = 0
	
func lvl_unlock(lvl_name):
	if !levels_unlocked.has(lvl_name):
		levels_unlocked.append(lvl_name)
	else:
		pass
