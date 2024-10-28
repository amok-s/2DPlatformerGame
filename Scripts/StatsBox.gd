extends Panel

@onready var deaths_label = $StatsContainer/DeathsLabel
@onready var fruits_label = $StatsContainer/FruitsLabel
@onready var mob_label = $StatsContainer/MobLabel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	deaths_label.text = "total deaths: " + str(Stats.global_deaths)
	fruits_label.text = "fruits eaten: " + str(Stats.fruits_eaten)
	mob_label.text = "mobs killed: " + str(Stats.mobs_killed)
